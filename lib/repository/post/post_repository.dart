import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tik_clone/models/post/post.dart';

class PostRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference post =
      FirebaseFirestore.instance.collection('post');


  /// Uploads the file and creates the collections and documents to store info about the video
  Future<String> uploadFile(
      File _image, String description, String user) async {
    CollectionReference userPost = firestore.collection(_auth.currentUser!.uid);
    String file = "";
    String userName = _auth.currentUser!.displayName == null
        ? "Usuario desconocido"
        : _auth.currentUser!.displayName!;
        String uId = _auth.currentUser!.displayName == null
        ? "Usuario desconocido"
        : _auth.currentUser!.uid;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(userName + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    uploadTask.then((res) async {
      file = await res.ref.getDownloadURL();
      Post _post = Post(
          userName: userName,
          uri: file,
          id: "",
          comments: {},
          uId: uId,
          likes: 0,
          description: description);
      post.add(_post.toJson());
      userPost.add(_post.toJson());
    });
    return file;
  }


  /// Gets all videos
  Future<List<Post>> getAll() async {
    List<Post> posts = [];
    await firestore.collection("post").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Post post = Post.fromJson(result.data());
        post.id = result.id;
        posts.add(post);
      });
    });
    return posts;
  }

  ///Gets all videos from a user
  Future<List<Post>> getFromUser(String user)async{
    List<Post> posts = [];
    await firestore.collection(user).get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        Post post = Post.fromJson(result.data());
        post.id = result.id;
        posts.add(post);
      });
    });
    return posts;
  }
}
