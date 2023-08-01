import 'dart:io';

class PostFormModel {
  String firstName;
  String lastName;
  File imageFile;
  String phoneNo;
  String email;

  PostFormModel({
    required this.firstName,
    required this.lastName,
    required this.imageFile,
    required this.phoneNo,
    required this.email,
  });
}
