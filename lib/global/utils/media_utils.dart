import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

abstract class MediaUtils {
  static Future<File> compressImage(File file, {required String postId}) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    img.Image? imageFile = img.decodeImage(file.readAsBytesSync());

    if (imageFile != null) {
      final compressedImageFile = File("$path/img_$postId.jpg")
        ..writeAsBytesSync(
          img.encodeJpg(
            imageFile,
            quality: 85,
          ),
        );
      return compressedImageFile;
    } else {
      throw Exception("Image not found");
    }
  }
}
