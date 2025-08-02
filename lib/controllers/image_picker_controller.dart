import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerController extends GetxController {
  RxString imagePath = ''.obs;

  Future getImage() async {
    final status = Platform.isAndroid
        ? await Permission.photos.request() // Android 13+
        : await Permission.photos.request(); // iOS & Android

    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        imagePath.value = image.path;
      }
    } else {
      Get.snackbar("Permission Denied", "Gallery access is required to pick images.");
      openAppSettings(); // optional
    }
  }
}