import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/main/posts/list.dart';
import 'package:social_app/services/posts.dart';
import 'package:social_app/services/user.dart';

class ProfileSearchBody extends StatefulWidget {
  final String userId;

  ProfileSearchBody({this.userId});
  @override
  _ProfileSearchBodyState createState() => _ProfileSearchBodyState();
}

class _ProfileSearchBodyState extends State<ProfileSearchBody> {
  UserService _userService = UserService();
  bool isFollowing = false;

  @override
  initState() {
    super.initState();
    _userService.isFollowing(widget.userId).then((val) {
      isFollowing = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
    return Provider.of<UserModel>(context) != null
        ? Scaffold(
            backgroundColor: bg,
            appBar: AppBar(
             
              backgroundColor: bg,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_sharp,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
            body: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(44)),
                      color: bg,
                    ),
                    width: double.infinity,
                    height: 406,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: ClipOval(
                            child: Image.network(
                              Provider.of<UserModel>(context).profileImgUrl ??
                                  '',
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, //Center Row contents horizontally,

                            children: [
                              Text(
                                Provider.of<UserModel>(context)?.name ?? '',
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Provider.of<UserModel>(context).isVerified
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Icon(Icons.verified,
                                          color: Colors.blue),
                                    )
                                  : Text('') ?? '',
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                      Provider.of<UserModel>(context)
                                          .followers
                                          .toString(),
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      )),
                                  Text(
                                    "Followers",
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal,
                                        color: tg,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                      Provider.of<UserModel>(context)
                                              .postAmount
                                              .toString() ??
                                          0,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  Text("Posts",
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C),
                                          fontSize: 15)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                      Provider.of<UserModel>(context)
                                          .following
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                  Text("Following",
                                      style: TextStyle(
                                          color: Color(0xff5C5C5C),
                                          fontSize: 15)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        FirebaseAuth.instance.currentUser.uid ==
                                Provider.of<UserModel>(context).id
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 23),
                                width: MediaQuery.of(context).size.width * 0.80,
                                child: OutlinedButton(
                                    style: ButtonStyle(backgroundColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((states) {
                                      return Color(0xffFE3B5B);
                                    })),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/edit');
                                    },
                                    child: Text("Edit Profile",
                                        style: TextStyle(color: Colors.white))),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.25),
                                child: Row(
                                  children: [
                                    isFollowing
                                        ? makeButton("Unfollow", () async {
                                            await _userService
                                                .unfollowUser(widget.userId);
                                            isFollowing = false;
                                            setState(() {});
                                          }, context)
                                        : makeButton("Follow", () async {
                                            await _userService
                                                .followUser(widget.userId);
                                            isFollowing = true;
                                            setState(() {});
                                          }, context),
                                  ],
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Text(Provider.of<UserModel>(context).bio,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                      color: Colors.white, fontSize: 15) ??
                                  ''),
                        ),
                      ],
                    )),
                ListPosts()
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
            backgroundColor: bg,
          );
  }

  Widget makeButton(text, function, context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 23),
      width: MediaQuery.of(context).size.width * 0.47,
      child: OutlinedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          return Color(0xffFE3B5B);
        })),
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
