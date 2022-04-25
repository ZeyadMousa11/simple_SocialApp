import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/modules/add_comment/add_comment.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/bloc/state.dart';
import 'package:socialapp/shared/components/compenents.dart';
import 'package:socialapp/shared/components/constantes.dart';
import 'package:socialapp/shared/style/icons_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context, state) {},
      builder: (context,state)
      {
       return ConditionalBuilder(
         condition: SocialCubit.get(context).posts.length>=0 && SocialCubit.get(context).model!=null,
         builder: (BuildContext context) =>SingleChildScrollView(
           physics: BouncingScrollPhysics(),
           child: Column(
             children: [
               ListView.separated(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context, index) => postBuildItem(SocialCubit.get(context).posts[index] ,context,index),
                 separatorBuilder: (context, index) => SizedBox(
                   height: 10,
                 ),
                 itemCount: SocialCubit.get(context).posts.length,
               ),
               SizedBox(
                 height: 10,
               ),
             ],
           ),
         ),
         fallback: (BuildContext context) =>Center(child: CircularProgressIndicator()),

       );
      },
    );
  }

  Widget postBuildItem(PostModel postModel,context,index) => Card(
        margin: EdgeInsets.symmetric(
          horizontal: 8,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${postModel.image}',
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${postModel.name}',
                              style: TextStyle(
                                height: 1.3,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          '${postModel.dateTime}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                height: 1.3,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: myLine(),
              ),
              Text(
                '${postModel.text}',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w300, height: 1.3
                ),
              ),
              // Padding(
              //   padding: const EdgeInsetsDirectional.only(
              //     bottom: 10,
              //     top: 5,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 5),
              //           child: Container(
              //             height: 20,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1,
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#software',
              //                 style: TextStyle(
              //                   color: defaultColor,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              if(postModel.postImage !='')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${postModel.postImage}',
                          ),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 16,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(SocialCubit.get(context).likesNumber[SocialCubit.get(context).postId[index]].toString(),
                                style: Theme.of(context).textTheme.caption),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('${SocialCubit.get(context).commentsNumber[SocialCubit.get(context).postId[index]].toString()}comments',
                                  style: Theme.of(context).textTheme.caption),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: myLine(),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).model!.image}'
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'write a comment ...',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      onTap: ()
                      {
                        navigateTo(context,CommentsScreen(postId: SocialCubit.get(context).postId[index]));
                      },
                    ),
                  ),
                  InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Like',
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                    onTap: ()
                    {
                      SocialCubit.get(context).likePosts(SocialCubit.get(context).postId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
