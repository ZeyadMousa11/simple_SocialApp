import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/bloc/state.dart';
import 'package:socialapp/shared/components/compenents.dart';
import 'package:socialapp/shared/components/constantes.dart';
import 'package:socialapp/shared/style/icons_broken.dart';
import 'dart:io';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context).model;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).profileCover;
        nameController.text = SocialCubit.get(context).model!.name!;
        bioController.text = SocialCubit.get(context).model!.bio!;
        phoneController.text = SocialCubit.get(context).model!.phone!;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            title: const Text(
              'Edit Profile',
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    SocialCubit.get(context).updateData(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  child: const Text('Update')),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is ProfileUserLoadingUpdate)
                    LinearProgressIndicator(),
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      image: coverImage == null
                                          ? NetworkImage('${cubit?.image}')
                                          : FileImage(coverImage)
                                              as ImageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getProfileCover();
                                },
                                icon: const CircleAvatar(
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 18,
                                  ),
                                  radius: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${cubit?.image}')
                                    : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 18,
                                ),
                                radius: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).profileCover != null)
                    Column(
                      children: [
                        Row(
                          children: [
                            if (SocialCubit.get(context).profileImage != null)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Add Photo',
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        IconBroken.Image,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (SocialCubit.get(context).profileCover != null)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'Add Cover',
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        IconBroken.Image_2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Update your name';
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Update your bio';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultTextFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Update your phone';
                      }
                      return null;
                    },
                    label: 'phone',
                    prefix: IconBroken.Call,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          signOut(context);
                        },
                        child:Row(
                          children: [
                            Text(
                              'SignOut',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              IconBroken.Logout,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
