import 'package:image_picker/image_picker.dart';

class AppImagePicker {
  static Function pickFromGallery = () async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    return file;
  };

  static Function pickFromCamera = () async {
    XFile? file = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    return file;
  };
}
