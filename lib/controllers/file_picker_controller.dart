import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerController extends GetxController {
  RxString fileName = ''.obs;
  RxString filePath = ''.obs;

  Future<void> pickFile() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.isNotEmpty) {
        fileName.value = result.files.single.name;
        filePath.value = result.files.single.path ?? '';
      }
    } else if (status.isPermanentlyDenied) {
      // Only open app settings if permission is permanently denied
      Get.snackbar("Permission Required",
          "Please enable storage permission in settings.");
      await openAppSettings();
    } else {
      Get.snackbar(
          "Permission Denied", "Storage access is required to pick files.");
      await openAppSettings();
    }
  }

  void clearFile() {
    fileName.value = '';
    filePath.value = '';
  }
}
