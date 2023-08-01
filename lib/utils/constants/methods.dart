import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<File?> convertImageUrlToFile(String imageUrl) async {
  try {
    // Fetch the image from the internet
    var response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      // Get the local directory path for saving the file
      var appDir = await getTemporaryDirectory();

      // Create a file with a unique name in the temporary directory
      var file = File(
          '${appDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Write the image data to the file
      await file.writeAsBytes(response.bodyBytes);

      // Return the file
      return file;
    } else {
      // Handle errors when the image cannot be downloaded
      throw Exception('Failed to download image');
    }
  } catch (e) {
    // Handle other exceptions
    print('Error: $e');
    return null;
  }
}
