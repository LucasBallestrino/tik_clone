import 'package:flutter/material.dart';
import 'package:tik_clone/models/post/post.dart';
import 'package:tik_clone/screens/home/tik_player.dart';

/// this is for showing the videos when tapped from the profile.

class ProfilePlayer extends StatefulWidget {
  final List<Post> posts;
  const ProfilePlayer({Key? key, required this.posts}) : super(key: key);

  @override
  _ProfilePlayerState createState() => _ProfilePlayerState();
}

class _ProfilePlayerState extends State<ProfilePlayer> {
  List<TikPlayerScreen> posts = [];

  @override
  void initState() {
    widget.posts.forEach((element) {
      posts.add(
        TikPlayerScreen(
          post: element,
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        scrollDirection: Axis.vertical,
        children: posts,
      ),
    );
  }
}
