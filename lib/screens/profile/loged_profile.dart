import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_clone/components/video_thum.dart';
import 'package:tik_clone/cubit/profile/profile_cubit.dart';
import 'package:tik_clone/models/post/post.dart';

import 'package:tik_clone/repository/post/post_repository.dart';
import 'package:tik_clone/screens/profile/profile_player.dart';

/// this is the real profile, shows you all the videos a user have uploaded

class LogedProfileScreen extends StatefulWidget {
  final bool ownProfile;
  final String user;
  final String userName;
  const LogedProfileScreen(
      {Key? key,
      required this.user,
      required this.userName,
      required this.ownProfile})
      : super(key: key);

  @override
  _LogedProfileScreenState createState() => _LogedProfileScreenState();
}

class _LogedProfileScreenState extends State<LogedProfileScreen> {
  late ProfileCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(PostRepository()),
      child: Builder(
        builder: (context) {
          _cubit = context.read<ProfileCubit>();
          _cubit.getAll(widget.user);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                widget.userName,
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              elevation: 1,
            ),
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: _body(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CircleAvatar(
          radius: 50,
          child: ClipOval(
            child: Image.network(
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"),
          ),
        ),
        Expanded(
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProfileInitial) {
                return loading();
              } else if (state is ProfileLoading) {
                return loading();
              } else if (state is ProfileLoaded) {
                return grid(state.posts);
              }
              return Container();
            },
          ),
        ),
        widget.ownProfile
            ? Container(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("LogOut"),
                ),
              )
            : Container()
      ],
    );
  }

  Widget grid(List<Post> posts) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: posts.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 9 / 16,
            crossAxisSpacing: 1,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePlayer(posts: posts),
                ),
              );
            },
            child: AnimatedThum(
              path: posts[index].uri,
            ),
          );
        },
      ),
    );
  }

  Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
