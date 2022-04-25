import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/home_layout.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';
import '../../shared/components/compenents.dart';
import '../../shared/components/constantes.dart';
import '../register_screen/register_screen.dart';
import 'bloc/cubit.dart';
import 'bloc/state.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) 
        {
          if(state is LoginSuccessState)
          {
            CashHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value){
              uId=state.uId;
              SocialCubit.get(context).getUsers();
              SocialCubit.get(context).getProfileCover();
              SocialCubit.get(context).getProfileImage();
              SocialCubit.get(context).userGetData();
              navigateToAndFinish(context, HomeScreen());
            });
          }
          else if(state is LoginErrorState)
            {
              showToast(text: state.error, state: ToastStates.error);
            }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: defaultColor,
                          ),
                        ),
                        const Text(
                          'login now to communicate with friends',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          suffixPressed: () {
                            LoginCubit.get(context).changeIconPassword();
                          },
                          isPassword: LoginCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Password';
                            }
                          },
                          label: 'password',
                          prefix: Icons.lock_open_outlined,
                          suffix: LoginCubit.get(context).suffix,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingStat,
                          builder: (context) => defaultButtons(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'LOGIN',
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: ()
                              {
                                navigateTo(context, RegisterScreen());
                              },
                              child: const Text(
                                'register',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
