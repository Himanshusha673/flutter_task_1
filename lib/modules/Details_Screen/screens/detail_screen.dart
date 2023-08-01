import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../Image_screen/model/get_image_data_model.dart';
import '../models/formModel.dart';
import '../services/details_screen_repo.dart';
import '../widgets/textform_widget.dart';
import '../widgets/validaions.dart';

class DetailsScreen extends StatefulWidget {
  Images imageData;
  File imageFileFuture;
  DetailsScreen(
      {super.key, required this.imageData, required this.imageFileFuture});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the TextEditingController instances
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    // Call the dispose method of the superclass
    super.dispose();
  }

  late Future<File?> _imageFileFuture;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Image.file(widget.imageFileFuture),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  widget.imageData.xtImage.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('First Name'),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          border: OutlineInputBorder(
                            // Add a border around the TextFormField
                            borderRadius: BorderRadius.circular(
                                8.0), // You can adjust the radius as needed
                            borderSide: const BorderSide(
                                color: Colors.grey), // Set the border color
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0), // Add padding inside the box
                          // You can customize other properties like fillColor, filled, labelText, etc.
                        ),
                        validator: (String? value) =>
                            Validations.validateName(value),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('Last Name'),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          border: OutlineInputBorder(
                            // Add a border around the TextFormField
                            borderRadius: BorderRadius.circular(
                                8.0), // You can adjust the radius as needed
                            borderSide: const BorderSide(
                                color: Colors.grey), // Set the border color
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0), // Add padding inside the box
                          // You can customize other properties like fillColor, filled, labelText, etc.
                        ),
                        validator: (String? value) =>
                            Validations.validateName(value),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('Email'),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            // Add a border around the TextFormField
                            borderRadius: BorderRadius.circular(
                                8.0), // You can adjust the radius as needed
                            borderSide: const BorderSide(
                                color: Colors.grey), // Set the border color
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 16.0), // Add padding inside the box
                          // You can customize other properties like fillColor, filled, labelText, etc.
                        ),
                        validator: (String? email) =>
                            Validations.emailValidator(email),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('Phone'),
                    ),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          border: OutlineInputBorder(
                            // Add a border around the TextFormField
                            borderRadius: BorderRadius.circular(
                                8.0), // You can adjust the radius as needed
                            borderSide: const BorderSide(
                                color: Colors.grey), // Set the border color
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 16.0), // Add padding inside the box
                          // You can customize other properties like fillColor, filled, labelText, etc.
                        ),
                        validator: (String? value) =>
                            Validations.phoneValidator(value),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        PostFormModel model = PostFormModel(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            phoneNo: _phoneController.text,
                            email: _emailController.text,
                            imageFile: widget.imageFileFuture);

                        bool isPost =
                            await DetailsDataRepositor.sendFormData(model);
                        if (isPost) {
                          showSnackbar("Posted SuccessFully !!!");
                        } else {
                          showSnackbar("Something went wrong");
                        }
                      } else {
                        showSnackbar("Please Fill all Feilds");
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
