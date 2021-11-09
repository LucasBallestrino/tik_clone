import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:tik_clone/models/post/post.dart';
import 'package:tik_clone/repository/post/post_repository.dart';
import 'dart:math';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _repository;
  PostCubit(this._repository) : super(PostInitial());
  Map<String, Post> posts = {};


  ///Get the initial videos
  Future<void> getInitial() async {
    try {
      emit(PostLoading());
      List<Post> response = await _repository.getAll();
      posts = {};
      for (var i = 0; i <= 5; i++) {
        var rng = Random();
        int index = rng.nextInt(response.length);
        String id = response[index].id;
        Post post = response[index];
        if (!posts.containsKey(id)) {
          posts[id] = post;
        }
      }
      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  ///Adds more videos to the queue
  Future<void> addMore()async{
    try {
      emit(PostLoading());
      List<Post> response = await _repository.getAll();
      for (var i = 0; i <= 5; i++) {
        var rng = Random();
        int index = rng.nextInt(response.length);
        String id = response[index].id;
        Post post = response[index];
        if (!posts.containsKey(id)) {
          posts[id] = post;
        }
      }
      emit(PostLoaded(posts: posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
