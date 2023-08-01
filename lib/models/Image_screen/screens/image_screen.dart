// Step 1: Import the necessary packages
import 'dart:io';

import 'package:flutter_application_int/models/Details_Screen/screens/detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/methods.dart';
import '../bloc/get_image_bloc.dart';
import '../model/get_image_data_model.dart';

class ImagesScreen extends StatelessWidget {
  List<Images> images = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetImageBloc, GetImageState>(
      listener: (context, state) {
        // You can handle any side effects here if needed
        if (state is GetImageFailure) {
          // Handle failure state, if required
        }
      },
      builder: (context, state) {
        if (state is GetImageInitial || state is GetImageLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is GetImageSuccess) {
          images.addAll(state.images);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: images.length + 1,
              itemBuilder: (context, index) {
                if (index < images.length) {
                  final imageUrl = images[index].xtImage;

                  return GestureDetector(
                    onTap: () async {
                      File? file =
                          await convertImageUrlToFile(images[index].xtImage!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                    imageData: images[index],
                                    imageFileFuture: file!,
                                  )));
                    },
                    child: Image.network(
                      imageUrl.toString(),
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      // Dispatch the FetchMoreImagesEvent to load more images
                      context.read<GetImageBloc>().add(GetImagesDataEvent());
                    },
                    child: const Text('Load More'),
                  );
                }
              },
            ),
          );
        } else if (state is GetImageFailure) {
          return Center(child: Text("error"));
        } else {
          return Container(); // Fallback case
        }
      },
    );
  }
}
