import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/bloc/state.dart';
import 'package:socialapp/shared/components/compenents.dart';
import 'package:socialapp/shared/style/icons_broken.dart';

import '../modules/add_post/add-post.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state)
      {
        if(state is AddPostState)
          {
            navigateTo(context, AddPost());
          }
      },
      builder: (context, state) {
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                cubit.title[cubit.currentIndex]
            ),
            actions: [
              IconButton(
                  onPressed: ()
                  {

                  }
                  , icon: const Icon(IconBroken.Notification)),
              IconButton(
                  onPressed: ()
                  {

                  }
                  , icon: const Icon(IconBroken.Search)),
            ],
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar
            (

            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeBottomNav(index);
            },
            items:
            const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.User),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                label: 'Setting',
                
              ),
            ],
          ),
        );
      },
    );
  }
}
