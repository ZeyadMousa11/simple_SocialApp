import 'package:flutter/material.dart';
import 'package:socialapp/modules/login_screen/login_screen.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/components/compenents.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';

const defaultColor=Colors.blue;
String? uId='';
void signOut(context) {
  CashHelper.removeData(key: 'uId');
  uId = null;
  var model = SocialCubit
      .get(context)
      .model;
  model!.name = '';
  model.phone = '';
  model.email = '';
  model.image='';
  model.cover='';
  navigateToAndFinish(context, LoginScreen());
  SocialCubit.get(context).currentIndex=0;
}