part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final Map<String, Post> posts;
  const PostLoaded({required this.posts});
}

class PostError extends PostState {
  final String error;
  const PostError(this.error);
}
