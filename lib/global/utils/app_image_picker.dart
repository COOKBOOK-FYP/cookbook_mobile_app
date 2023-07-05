import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  static Future<File> pickFromGallery() async {
    XFile? xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (xFile == null) {
      throw Exception('File not selected');
    } else {
      // convert XFile to File
      File file = File(xFile.path);
      return file;
    }
  }

  static Future<File> pickFromCamera() async {
    XFile? xFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    if (xFile == null) {
      throw Exception('File not selected');
    } else {
      // convert XFile to File
      File file = File(xFile.path);
      return file;
    }
  }
}
