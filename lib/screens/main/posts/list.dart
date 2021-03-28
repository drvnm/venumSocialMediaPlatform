import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/models/user.dart';

import 'dart:core';

class ListPosts extends StatefulWidget {
  @override
  _ListPostsState createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  @override
  Widget build(BuildContext context) {
    Color bg = Color(0xff1E1E1E);
    Color fg = Color(0xff222222);
    final posts = Provider.of<List<PostModel>>(context) ?? [];
    final userInfo = Provider.of<UserModel>(context) ?? null;
    return posts.length > 0 ? Expanded(
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          Timestamp time = posts[index].timestamp;
          int timeInMillis = time.millisecondsSinceEpoch;
          var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis)
              .toString()
              .substring(0, 10);

          return Card(
            color: bg,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(userInfo.profileImgUrl),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, bottom: 0),
                      child: Text(userInfo.name ?? 'LOADING',
                          style: TextStyle(color: Colors.white)),
                    ),
                    Provider.of<UserModel>(context).isVerified
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 6.0, bottom: 3),
                            child: Icon(Icons.verified, color: Colors.blue),
                          )
                        : Text(''),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(date,
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ),
                  ],
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
                  top: 4,
                ),
                child: Text(post.text ?? '',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    ) : Center(heightFactor: 8,child:Text("This user has no posts yet.", style: TextStyle(color: Colors.white)));
  }
}
