import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String text;
  final Timestamp timestamp;
  final String creator;

  MessageModel({this.text, this.timestamp, this.creator});
}