import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String text;
  final Timestamp timestamp;
  final String creator;
  final String profileImgUrl;
  final bool isVerified;
  final String name;

  MessageModel(
      {this.text,
      this.timestamp,
      this.creator,
      this.profileImgUrl,
      this.isVerified,
      this.name});
}
