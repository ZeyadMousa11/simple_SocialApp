abstract class SocialState{}

class SocialInitialState extends SocialState{}

class GetUserLoadingState extends SocialState{}
class GetUserSuccessState extends SocialState{}
class GetUserErrorState extends SocialState
{
  final String error;
  GetUserErrorState(this.error);
}

class ChangeBottomNavBarState extends SocialState{}

class AddPostState extends SocialState{}

class ProfileImagePickedSuccess extends SocialState{}
class ProfileImagePickedError extends SocialState{}

class ProfileCoverImagePickedSuccess extends SocialState{}
class ProfileCoverImagePickedError extends SocialState{}

class ProfileUploadProfileImageSuccess extends SocialState{}
class ProfileUploadProfileImageError extends SocialState{}

class ProfileUploadCoverImageSuccess extends SocialState{}
class ProfileUploadCoverImageError extends SocialState{}

class ProfileUserUpdateError extends SocialState{}
class ProfileUserLoadingUpdate extends SocialState{}

class CreatePostLoading extends SocialState{}
class CreatePostSuccess extends SocialState{}
class CreatePostError extends SocialState{}

class PostImagePickedSuccess extends SocialState{}
class PostImagePickedError extends SocialState{}

class RemovePostImage extends SocialState{}

class GetPostsLoadingState extends SocialState{}
class GetPostsSuccessState extends SocialState{}
class GetPostsErrorState extends SocialState
{
  final String error;
  GetPostsErrorState(this.error);
}

class LikePostsLoadingState extends SocialState{}
class LikePostsSuccessState extends SocialState{}
class LikePostsErrorState extends SocialState
{
  final String error;
  LikePostsErrorState(this.error);
}

class CommentsPostsLoadingState extends SocialState{}
class CommentsPostSuccessState extends SocialState{}
class CommentsPostErrorState extends SocialState
{
  final String error;
  CommentsPostErrorState(this.error);
}

class GetAllUsersLoadingState extends SocialState{}
class GetAllUsersSuccessState extends SocialState{}
class GetAllUsersErrorState extends SocialState
{
  final String error;
  GetAllUsersErrorState(this.error);
}

class SendMessageSuccess extends SocialState{}
class SendMessageError extends SocialState{}

class GetMessageSuccess extends SocialState{}
class GetMessageError extends SocialState{}

