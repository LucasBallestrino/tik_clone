import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tik_clone/repository/post/post_repository.dart';

part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final PostRepository repository;
  UploadCubit({required this.repository}) : super(UploadInitial());

  Future<void> publishVideo(
      File _image, String description, String user) async {
    emit(UploadLoading());
    var response = await repository.uploadFile(_image, description, user);
    if (response != null) {
      emit(UploadLoaded(uri: ""));
    } else {
      emit(UploadError());
    }
  }
}
