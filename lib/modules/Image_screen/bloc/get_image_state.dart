part of 'get_image_bloc.dart';

@immutable
abstract class GetImageState {}

class GetImageInitial extends GetImageState {}

class GetImageLoading extends GetImageState {}

class FetchMoreImageLoading extends GetImageState {}

class GetImageSuccess extends GetImageState {
  final List<Images> images;
  GetImageSuccess({
    required this.images,
  });
}

class GetImageFailure extends GetImageState {}
