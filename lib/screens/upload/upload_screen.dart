import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tik_clone/cubit/post/upload_cubit.dart';
import 'package:tik_clone/repository/post/post_repository.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadScreen extends StatefulWidget {
  final void Function() onTap;
  const UploadScreen({Key? key, required this.onTap}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  TextEditingController _desc = TextEditingController();
  late UploadCubit _cubit;
  File? video;
  final ImagePicker _picker = ImagePicker();
  Uint8List? thumb;
  @override
  initState() {
    pickVideo();
    super.initState();
  }

  Future<void> pickVideo() async {
    final uploadedVIdeo = await _picker.pickVideo(source: ImageSource.gallery);
    setState(() {
      video = File(uploadedVIdeo!.path);
      getVideoThumb();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text(
            "Subir",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: BlocProvider(
        create: (context) => UploadCubit(repository: PostRepository()),
        child: Builder(
          builder: (context) {
            _cubit = context.read<UploadCubit>();
            return BlocConsumer<UploadCubit, UploadState>(
              listener: (context, state) {
              },
              builder: (context, state) {
                if (state is UploadInitial) {
                  return body();
                } else if (state is UploadLoading) {
                  return loading();
                } else if (state is UploadLoaded) {
                  return success();
                }
                return error();
              },
            );
          },
        ),
      ),
    );
  }

  Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget success() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check,
            color: Colors.green,
            size: 70,
          ),
          Text(
            "Video publicado correctamente",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              onPressed: widget.onTap,
              child: Text("Volver"))
        ],
      ),
    );
  }

  Widget error() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
            size: 70,
          ),
          Text(
            "Error al publicar el video",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              onPressed: widget.onTap,
              child: Text("Volver"))
        ],
      ),
    );
  }

  Widget body() {
    return video == null
        ? Center(
            child: videoPicker(),
          )
        : Container(
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            child: description(),
          );
  }

  Widget description() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _desc,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: InputDecoration(
                    focusedBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                    hintText: "Describe tu video",
                    border: UnderlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
              thumb == null ? Container(): Image.memory(thumb!)
            ],
          ),
          Container(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Color.fromARGB(200, 100, 100, 100),
            height: 0.5,
            
          ),
          Container(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              publishVideo();
            },
            child: Text("Publicar"),
          ),
        ],
      ),
    );
  }

  Widget videoPicker() {
    return Center(
      child: ElevatedButton(
        onPressed: pickVideo,
        child: Text("Selecciona un video."),
      ),
    );
  }

  getVideoThumb() async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: video!.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          100, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    setState(() {
      thumb = uint8list;
    });
  }

  Future<void> publishVideo() async {
    _cubit.publishVideo(video!, _desc.text, "user");
  }
}
