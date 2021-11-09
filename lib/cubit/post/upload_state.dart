part of 'upload_cubit.dart';

@immutable
abstract class UploadState extends Equatable{}

class UploadInitial extends UploadState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadLoading extends UploadState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadLoaded extends UploadState {
  final String uri;
  UploadLoaded({required this.uri});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UploadError extends UploadState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
