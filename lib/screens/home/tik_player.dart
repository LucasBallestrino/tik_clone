import 'package:flutter/material.dart';
import 'package:tik_clone/models/post/post.dart';
import 'package:tik_clone/screens/profile/loged_profile.dart';

import 'package:video_player/video_player.dart';
import 'dart:math' as math;

class TikPlayerScreen extends StatefulWidget {
  final Post post;
  const TikPlayerScreen({Key? key, required this.post}) : super(key: key);

  @override
  _TikPlayerScreenState createState() => _TikPlayerScreenState();
}

// This screen would be the base for all TikToks in the list.
class _TikPlayerScreenState extends State<TikPlayerScreen> {
  late VideoPlayerController _videoController;


  /// init to the videocontroller
  @override
  void initState() {
    _videoController = VideoPlayerController.network(widget.post.uri)
      ..initialize().then((_) {
        setState(() {});
      });
    setState(() {
      _videoController.play();
    });
    super.initState();
    _videoController.setLooping(true);
  }

  @override
  void dispose() {
    setState(() {
      _videoController.pause();
      _videoController.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _videoBody(),
        Align(
          alignment: Alignment.center,
          child: _videoStatus(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _videoProgress(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: _videoDescription(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: _rightButtons(),
        )
      ],
    );
  }

  //returns the video progress indicator
  Widget _videoProgress() {
    return VideoProgressIndicator(
      _videoController,
      allowScrubbing: true,
      colors: VideoProgressColors(
          backgroundColor: Colors.transparent,
          playedColor: Colors.white,
          bufferedColor: Color.fromARGB(200, 255, 255, 255)),
    );
  }

  //returns the video body itself
  Widget _videoBody() {
    return GestureDetector(
      onTap: _playTap,
      child: Center(
        child: _videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
            : Container(),
      ),
    );
  }

  //returns the video status indicator
  Widget _videoStatus() {
    return !_videoController.value.isPlaying
        ? GestureDetector(
            onTap: _playTap,
            child: Icon(
              Icons.play_arrow_rounded,
              size: 90,
              color: Color.fromARGB(200, 255, 255, 255),
            ),
          )
        : Container();
  }

  //returns the video desciption and username
  Widget _videoDescription() {
    return Container(
      padding: EdgeInsets.only(left: 20, bottom: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "@" + widget.post.userName,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Container(
            height: 15,
            width: 0,
          ),
          Text(
            widget.post.description,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// returns the video button on the side, the buttons do nothing yet.

  Widget _rightButtons() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(padding: EdgeInsets.only(bottom: 30), child: pfp()),
          Icon(
            Icons.favorite,
            color: Colors.white,
            size: 35,
          ),
          Container(
            child: Text(
              "10.9K",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            padding: EdgeInsets.only(bottom: 30),
          ),
          Icon(
            Icons.comment,
            color: Colors.white,
            size: 35,
          ),
          Container(
            child: Text(
              "2.3K",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            padding: EdgeInsets.only(bottom: 30),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Icon(
              Icons.reply,
              color: Colors.white,
              size: 35,
            ),
          ),
          Container(
            child: Text(
              "Compartir",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            padding: EdgeInsets.only(bottom: 30),
          ),
        ],
      ),
    );
  }

  /// returns the profile pic

  Widget pfp() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LogedProfileScreen(
              user: widget.post.uId,
              userName: widget.post.userName,
              ownProfile: false,
            ),
          ),
        );
      },
      child: CircleAvatar(
        backgroundImage: NetworkImage(
            "https://simg.nicepng.com/png/small/128-1280406_view-user-icon-png-user-circle-icon-png.png"),
      ),
    );
  }

  /// changes the state of the video.

  void _playTap() {
    setState(() {
      _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play();
    });
  }
}
