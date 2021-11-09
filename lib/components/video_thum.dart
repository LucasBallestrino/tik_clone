

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class AnimatedThum extends StatefulWidget {
  final String path;
  const AnimatedThum({Key? key, required this.path}) : super(key: key);

  @override
  _AnimatedThumState createState() => _AnimatedThumState();
}

///component to show a thumb in profiles

class _AnimatedThumState extends State<AnimatedThum>
    with AfterLayoutMixin<AnimatedThum> {
   VideoPlayerController? _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _videoPlayerController == null? Center(child: CircularProgressIndicator(),): 
      AspectRatio(
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        child:  VideoPlayer(_videoPlayerController!),
      ),
    );
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    _videoPlayerController = VideoPlayerController.network(
      widget.path,
    )..initialize().then((_) {
        setState(() {});
      });
    setState(() {
      _videoPlayerController!.play();
      _videoPlayerController!.setVolume(0.0);
      _videoPlayerController!.setPlaybackSpeed(1.5);
      _videoPlayerController!.setLooping(true);
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }
}
