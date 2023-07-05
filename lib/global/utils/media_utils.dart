import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

abstract class MediaUtils {
  Future<File> compressImage(File file, {required String postId}) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    img.decodeImage(file.readAsBytesSync());

    final compressedImageFile = File("$path/img_$postId.jpg")
      ..writeAsBytesSync(
        img.encodeJpg(
          img.copyResize(
            img.decodeImage(file.readAsBytesSync())!,
            width: 500,
            height: 500,
          ),
        ),
      );
    return compressedImageFile;
  }
}
