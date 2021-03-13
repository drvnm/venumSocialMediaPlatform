class UserModel {
  final String id;
  final String email;
  final int following;
  final int followers;
  final String profileImgUrl;
  final String name;
  final String bio;
  final bool isVerified;
  final int postAmount;

  UserModel(
      {this.id,
      this.email,
      this.following,
      this.followers,
      this.profileImgUrl,
      this.name,
      this.bio,
      this.isVerified,
      this.postAmount});
}
