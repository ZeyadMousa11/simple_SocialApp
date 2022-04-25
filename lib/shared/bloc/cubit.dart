import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/models/comment_model.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/add_post/add-post.dart';
import 'package:socialapp/modules/chats/chats_screen.dart';
import 'package:socialapp/modules/feeds/fedds_screen.dart';
import 'package:socialapp/modules/setting/setting_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';
import 'package:socialapp/shared/bloc/state.dart';
import 'package:socialapp/shared/components/constantes.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

// ---------------------getUserData------------------------------
  UserModel? model;

  void userGetData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('Users').doc(uId).get().then((value) {
      // print(value.data());
      model = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

// ---------------------changeIndexNavBar------------------------------
  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    AddPost(),
    NativeCode(),
    SettingScreen(),
  ];
  List<String> title = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Setting',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(AddPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

  // ---------------------getProfileImage------------------------------
  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccess());
    } else {
      print('No Image Selected');
      emit(ProfileImagePickedError());
    }
  }

// ---------------------getCoverImage------------------------------
  File? profileCover;

  Future<void> getProfileCover() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileCover = File(pickedFile.path);
      emit(ProfileCoverImagePickedSuccess());
    } else {
      print('No Image Selected');
      emit(ProfileCoverImagePickedError());
    }
  }

// ---------------------uploadProfileImage------------------------------
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(ProfileUserLoadingUpdate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateData(name: name, phone: phone, bio: bio, image: value);
        print(value);
      }).catchError((error) {
        emit(ProfileUploadProfileImageError());
        print(error.toString());
      });
    }).catchError((error) {
      emit(ProfileUploadProfileImageError());
      print(error.toString());
    });
  }

// ---------------------uploadCoverImage------------------------------
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(ProfileUserLoadingUpdate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${Uri.file(profileCover!.path).pathSegments.last}')
        .putFile(profileCover!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateData(name: name, phone: phone, bio: bio, cover: value);
        print(value);
      }).catchError((error) {
        emit(ProfileUploadCoverImageError());
        print(error.toString());
      });
    }).catchError((error) {
      emit(ProfileUploadCoverImageError());
      print(error.toString());
    });
  }

// ---------------------updateData------------------------------
  void updateData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    UserModel userModel = UserModel(
      phone: phone,
      name: name,
      uId: uId,
      bio: bio,
      email: model!.email,
      cover: cover ?? model!.cover,
      image: image ?? model!.image,
      // isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel.uId)
        .update(userModel.toMap())
        .then((value) {
      userGetData();
    }).catchError((error) {
      emit(ProfileUserUpdateError());
    });
  }

// ---------------------getPostImage------------------------------
  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccess());
    } else {
      print('No Image Selected');
      emit(PostImagePickedError());
    }
  }

// ---------------------removePostImage------------------------------
  void removePostImage() {
    postImage = null;
    emit(RemovePostImage());
  }

// ---------------------uploadPostImage------------------------------
  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostLoading());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(dateTime: dateTime, text: text, postImage: value);
        print(value);
      }).catchError((error) {
        emit(CreatePostError());
        print(error.toString());
      });
    }).catchError((error) {
      emit(CreatePostError());
      print(error.toString());
    });
  }

// ---------------------createPost------------------------------
  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(CreatePostLoading());
    PostModel postModel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccess());
    }).catchError((error) {
      emit(CreatePostError());
    });
  }

// ---------------------getPost && likeGetPost------------------------------
  List<PostModel> posts = [];
  List<String> postId = [];
  Map<String, int> commentsNumber = {};
  Map<String, int> likesNumber = {};
  Map<String, int> postsNumber = {};

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      for (var post in value.docs) {
        post.reference.collection('comments').get().then((value) {
          commentsNumber.addAll({post.id: value.docs.length});
        }).catchError((error) {
          print('error');
        });
      }
      for (var post in value.docs) {
        post.reference.collection('likes').get().then((value) {
          posts.add(PostModel.fromJson(post.data()));
          postId.add(post.id);
          likesNumber.addAll({post.id: value.docs.length});
          emit(GetPostsSuccessState());
        });
      }
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

// ---------------------likePost------------------------------
  void likePosts(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.uId)
        .set({'likes': true}).then((value) {
      emit(LikePostsSuccessState());
    }).catchError((error) {
      emit(LikePostsErrorState(error.toString()));
    });
  }

// ---------------------writeComment------------------------------
  CommentModel? commentModel;

  void writeComment({
    required String postId,
    required String dateTime,
    required String text,
  }) {
    commentModel = CommentModel(
      name: model!.name,
      uId: model!.uId,
      profileImage: model!.image,
      dateTime: dateTime,
      text: text,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel!.toMap())
        .then((value) {
      emit(CommentsPostSuccessState());
    }).catchError((error) {
      emit(CommentsPostErrorState(error.toString()));
    });
  }

// ---------------------getComment------------------------------
  List<CommentModel> comments = [];

  void getComments({
    required String postId,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      comments = [];
      event.docs.forEach((element) {
        //commentsNumber.add(event.docs.length);
        comments.add(CommentModel.fromJson(element.data()));
      });
      emit(CommentsPostSuccessState());
    });
  }

// ---------------------allUsers------------------------------
  List<UserModel> users = [];

  void getUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('Users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != model!.uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        });
        emit(GetAllUsersSuccessState());
      }).catchError((error) {
        emit(GetAllUsersErrorState(error.toString()));
      });
    }
  }

// ---------------------sendMessage------------------------------
  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel messageModel = MessageModel(
      text: text,
      senderId: model!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError());
    });

    FirebaseFirestore.instance
        .collection('Users')
        .doc(receiverId)
        .collection('chat')
        .doc(model!.uId)
        .collection('message')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError());
    });
  }

// ---------------------getMessage------------------------------
  List<MessageModel> messages = [];

  void getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(model!.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages.clear();
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccess());
    });
  }
}
