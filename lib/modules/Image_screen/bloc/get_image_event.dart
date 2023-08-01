part of 'get_image_bloc.dart';

@immutable
abstract class GetImageEvent extends Equatable {}

class GetImagesDataEvent extends GetImageEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
