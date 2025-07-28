import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class FilePickerController extends GetxController {
  RxString fileName = ''.obs;
  RxString filePath = ''.obs;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.isNotEmpty) {
      fileName.value = result.files.single.name;
      filePath.value = result.files.single.path ?? '';
    }
    print("print = $filePath");
  }

  void clearFile() {
    fileName.value = '';
    filePath.value = '';
  }

}
