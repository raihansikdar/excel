import 'package:excel_app/models/excel_file_model.dart';
import 'package:excel_app/network/file_upload_repository.dart';
import 'package:get/get.dart';

class ExcelFileUploadingViewModel extends GetxController
    with StateMixin<String> {
  final _repository = FileUploadRepository();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
  }

  Future<void> uploadExcelFile() async {
    try {
      final excelPath = await _repository.pickExcelFile();
      if (excelPath != null) {
        change(excelPath, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error('No file selected'));
      }
    } catch (e) {
      change(null, status: RxStatus.error('Error : ${e.toString()}'));
    }
  }
}
