import 'package:flutter/material.dart';
import 'package:flutter_application_int/models/Image_screen/screens/image_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_image_bloc.dart';

class DisplayImagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetImageBloc()..add(GetImagesDataEvent()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Images '),
        ),
        body: ImagesScreen(),
      ),
    );
  }
}
