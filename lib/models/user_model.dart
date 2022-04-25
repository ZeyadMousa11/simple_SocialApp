class UserModel
{
  String? name;
  String? phone;
  String? email;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  // late bool isEmailVerified;

  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.cover,
    this.bio,
    // required this.isEmailVerified,
});

  UserModel.fromJson(Map<String,dynamic>?json)
  {
    email=json!['email'];
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    cover=json['cover'];
    bio=json['bio'];
    // isEmailVerified=json['isEmailVerified'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      // 'isEmailVerified':isEmailVerified,
  };
  }
}