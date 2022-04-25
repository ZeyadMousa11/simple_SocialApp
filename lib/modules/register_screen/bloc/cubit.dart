
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/register_screen/bloc/state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // ---------------------userCreate------------------------------
  UserModel? userModel;
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      email: email,
      phone: phone,
      name: name,
      uId: uId,
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNDyf8ALfj7HbMu11Z1Wp9YawdywSB7JO9fsw_Zm5p&s',
      bio: 'write your bio ...',
      cover:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNDyf8ALfj7HbMu11Z1Wp9YawdywSB7JO9fsw_Zm5p&s',
      // isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreateSuccessState(uId));
    }).catchError((error) {
      emit(CreateErrorState(error.toString()));
    });
  }

  // ---------------------userRegister------------------------------
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingStat());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  // ---------------------changeIconPassword------------------------------
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeIconPassword() {
    isPassword = !isPassword;
    if (isPassword) {
      suffix = Icons.visibility_outlined;
    } else {
      suffix = Icons.visibility_off_outlined;
    }
    emit(ChangeIconPassword());
  }
}
