import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/shared/bloc/cubit.dart';
import 'package:socialapp/shared/bloc/state.dart';
import 'package:socialapp/shared/style/icons_broken.dart';

class AddPost extends StatelessWidget {
  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
       listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            title: Text(
              'Create Post',
            ),
            actions: [
              TextButton(
                onPressed: ()
                {
                  var now=DateTime.now();
                  if(SocialCubit.get(context).postImage==null)
                  {
                    SocialCubit.get(context).createPost(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  }else
                  {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                  }
                  textController.clear();
                },
                child: Text('Post'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoading)
                  LinearProgressIndicator(),
                if(state is CreatePostLoading)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        SocialCubit.get(context).model!.image!
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                     SocialCubit.get(context).model!.name!,
                        style: TextStyle(
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is your mind .....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if(SocialCubit.get(context).postImage !=null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: FileImage(SocialCubit.get(context).postImage!),
                            fit: BoxFit.cover,
                          )),
                    ),
                    IconButton(
                      color: Colors.grey[300],
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: const CircleAvatar(
                        child: Icon(
                          Icons.close,
                          size: 18,
                        ),
                        radius: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Add Photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: Text(
                            '# tags'
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
