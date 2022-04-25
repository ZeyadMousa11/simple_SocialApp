
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/chat_details/chat_deatiles.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/bloc/state.dart';
import 'package:socialapp/shared/components/compenents.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state)
    {
      return ConditionalBuilder(
        condition: SocialCubit.get(context).users.length>0,
          builder: (context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context,index)=>myLine(),
            itemCount: SocialCubit.get(context).users.length,
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
      );
    }
    );
  }
  Widget buildChatItem(UserModel models,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              '${models.image}',
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            '${models.name}',
            style: TextStyle(
              height: 1.3,
            ),
          ),
        ],
      ),
      onTap: ()
      {
        navigateTo(context, ChatDetailsScreen(userModel: models,));
      },
    ),
  );
}
