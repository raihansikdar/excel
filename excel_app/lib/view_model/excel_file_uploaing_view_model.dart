import 'package:excel_app/models/excel_file_model.dart';
import 'package:excel_app/network/file_upload_repository.dart';
import 'package:get/get.dart';

class ExcelFileUploadingViewModel extends GetxController with StateMixin<List<ExcelFileModel>>{
 final _repository = FileUploadRepository();
 
  Future<void> uploadExcelFile() async {
    try {
      final selectedExcelFiles  = await _repository.pickExcelFile();
      if (selectedExcelFiles  != null) {
        change(selectedExcelFiles  as List<ExcelFileModel>?, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error('No file selected'));
      }
    } catch (e) {
      change(null, status: RxStatus.error('Error : ${e.toString()}'));
    }
  }
}