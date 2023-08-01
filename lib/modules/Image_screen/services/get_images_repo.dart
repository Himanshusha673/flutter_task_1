import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../../utils/constants/ApiConstants/api_constants.dart';
import '../model/get_image_data_model.dart';

class ImageScreenRepository {
  static Future<GetImageData?> getImages(
    int OffSet,
  ) async {
    log('here');
    try {
      var response =
          await http.post(Uri.parse(ApiConstants.getImageData), body: {
        'user_id': '108',
        'offset': OffSet.toString(),
        'type': 'popular',
      });
      log('yes');

      log(response.body.toString());
      if (response.statusCode == 200) {
        GetImageData responseData =
            GetImageData.fromJson(jsonDecode(response.body));
        return responseData;
      } else {
        throw Exception("Failed to update form data");
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
