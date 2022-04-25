import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/login_screen/bloc/state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingStat());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
        password: password,
    ).then((value) {
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

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