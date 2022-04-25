
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layout/home_layout.dart';
import 'package:socialapp/modules/register_screen/bloc/cubit.dart';
import 'package:socialapp/modules/register_screen/bloc/state.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/components/compenents.dart';
import 'package:socialapp/shared/components/constantes.dart';
import 'package:socialapp/shared/network/local/cash_helper.dart';

class RegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          if(state is CreateSuccessState)
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
                          'REGISTER',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: defaultColor,
                          ),
                        ),
                        const Text(
                          'register now to communicate with friends',
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
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your name';
                            }
                          },
                          label: 'User name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your phone';
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultTextFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Email';
                            }
                          },
                          label: 'Email',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextFormField(
                          suffixPressed: () {
                            RegisterCubit.get(context).changeIconPassword();
                          },
                          isPassword: RegisterCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your Password';
                            }
                          },
                          label: 'password',
                          prefix: Icons.lock_open_outlined,
                          suffix: RegisterCubit.get(context).suffix,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingStat,
                          builder: (context) => defaultButtons(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'REGISTER',
                          ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 15,
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
