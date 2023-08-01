import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_int/models/Details_Screen/models/formModel.dart';
import 'package:flutter_application_int/utils/constants/ApiConstants/api_constants.dart';
import 'package:http/http.dart' as http;

class DetailsDataRepositor {
  static Future<bool> sendFormData(PostFormModel model) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(ApiConstants.saveFormData));

      request.fields['first_name'] = model.firstName;
      request.fields['last_name'] = model.lastName;
      request.fields['email'] = model.email;
      request.fields['phone'] = model.phoneNo;

      // Step 1-- by using file path

      var multipartFile =
          await http.MultipartFile.fromPath('image', model.imageFile.path);

      // Step: 2 by using file
      //  var fileStream = http.ByteStream(Stream.castFrom(_imageFile!.openRead()));
      // var length = await model.imageFile.length();
      // var multipartFile = http.MultipartFile('image', fileStream, length,
      //     filename: model.imageFile.path.split('/').last);

      request.files.add(multipartFile);

      var response = await request.send();

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
