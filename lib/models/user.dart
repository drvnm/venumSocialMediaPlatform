class UserModel {
  final String id;
  final String email;
  final String profileImgUrl;
  final String name;
  final String bio;
  final bool isVerified;
  final int postAmount;


  UserModel({this.id, this.email, this.profileImgUrl, this.name, this.bio, this.isVerified, this.postAmount});
}
