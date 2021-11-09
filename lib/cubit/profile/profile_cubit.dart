import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_clone/models/post/post.dart';
import 'package:tik_clone/repository/post/post_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final PostRepository _postRepository;
  ProfileCubit(this._postRepository) : super(ProfileInitial());


  /// Gets all videos from a user.
  Future<void> getAll(String user)async {
    try{
      emit(ProfileLoading());
      List<Post> posts = await _postRepository.getFromUser(user);
      emit(ProfileLoaded(posts));
    }catch(e){
      emit(ProfileError());
    }
  }
}
