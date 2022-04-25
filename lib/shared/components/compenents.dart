
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/modules/add_comment/add_comment.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/components/constantes.dart';
import 'package:socialapp/shared/style/icons_broken.dart';

void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));

void navigateToAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Widget,
        ), (route) {
      return false;
    });

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit as void Function(String)?,
      onChanged: onChange as void Function(String)?,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        helperStyle: TextStyle(color: defaultColor),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: defaultColor,
            )),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(15),right: Radius.circular(15)),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.all(0),
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        enabled: isClickable,
      ),
    );

Widget defaultButtons({
  double width = double.infinity,
  // Color color=HexColor('333739'),
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
        ),
        child: MaterialButton(
          color: defaultColor,
          onPressed: () {
            function();
          },
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );
enum ToastStates { success, error, warning }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}

Widget myLine() => Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconBroken.Arrow___Left_3),
      ),
      title: Text(
        title!,
      ),
      actions: actions,
    );
