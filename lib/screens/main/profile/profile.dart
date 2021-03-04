import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/main/posts/list.dart';
import 'package:social_app/services/posts.dart';
import 'package:social_app/services/user.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PostService _postService = PostService();
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    Color bg = Color(0xff181818);
    Color fg = Color(0xff222222);

    return MultiProvider(
      providers: [
        StreamProvider.value(
            value: _postService
                .getPostsByUser(FirebaseAuth.instance.currentUser.uid)),
        StreamProvider.value(
            value:
                _userService.getUserInfo(FirebaseAuth.instance.currentUser.uid))
      ],
      child: Scaffold(
          body: DefaultTabController(
              child: Container(
                color: fg,
                child: NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(30)),
                                  color: bg,
                                ),
                                width: double.infinity,
                                height: 350,
                                child: Column(
                                  
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: ClipOval(
                                        child: Image.network(
                                          Provider.of<UserModel>(context)
                                                  .profileImgUrl ??
                                              '',
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,

                                        children: [
                                          Text(Provider.of<UserModel>(context).name, style: TextStyle(color: Colors.white, fontSize: 20)),
                                          
                                          Provider.of<UserModel>(context).isVerified ? Icon(Icons.verified, color: Colors.blue) : Text(''),
                                          
                                        ],
                                        
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        
                                        mainAxisAlignment: MainAxisAlignment.spaceAround, 

                                        children: [
                                          Column(children: [Text("Followers", style: TextStyle(color: Colors.white, fontSize: 20)), Text("0",style: TextStyle(color: Colors.white, fontSize: 20))],),
                                          Column(children: [Text("Following", style: TextStyle(color: Colors.white, fontSize: 20)), Text("0",style: TextStyle(color: Colors.white, fontSize: 20)),],)
                                          
                                        ],
                                        
                                      ),
                                    ),
                                    TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/edit');
                                          },
                                          child: Text("Edit profile")),
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Text(Provider.of<UserModel>(context).bio, textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 12)),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )
                    ];
                  },
                  body: ListPosts(),
                ),
              ),
              length: 2)),
    );
  }
}

// body: DefaultTabController(
//               child: NestedScrollView(
//                 headerSliverBuilder: (context, _) {
//                   return [
//                     SliverAppBar(
//                       floating: false,
//                       pinned: true,
//                       expandedHeight: 130,
//                       flexibleSpace: FlexibleSpaceBar(
//                         background: Image.network(
//                           Provider.of<UserModel>(context).profileImgUrl ?? '',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     SliverList(
//                       delegate: SliverChildListDelegate(
//                         [
//                           Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 20, horizontal: 50),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Image.network(
//                                         Provider.of<UserModel>(context)
//                                                 .profileImgUrl ??
//                                             '',
//                                         fit: BoxFit.cover,
//                                         height: 60,
//                                       ),
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pushNamed(
//                                                 context, '/edit');
//                                           },
//                                           child: Text("Edit profile"))
//                                     ],
//                                   ),
//                                   Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 10),
//                                           child: Text(
//                                               Provider.of<UserModel>(context)
//                                                   .name)))
//                                 ],
//                               ))
//                         ],
//                       ),
//                     )
//                   ];
//                 },
//                 body: ListPosts(),
//               ),
//               length: 2)
