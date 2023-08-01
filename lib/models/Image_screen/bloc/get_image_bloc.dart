import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../model/get_image_data_model.dart';
import '../services/get_images_repo.dart';

part 'get_image_event.dart';
part 'get_image_state.dart';

class GetImageBloc extends Bloc<GetImageEvent, GetImageState> {
  int offset = 0;
  GetImageBloc() : super(GetImageInitial()) {
    on<GetImagesDataEvent>((event, emit) async {
      GetImageData? res = await ImageScreenRepository.getImages(offset);
      if (res == null) {
        emit(GetImageFailure());
      } else {
        offset++;

        emit(GetImageSuccess(images: res.images!));
      }
    });
  }
}
