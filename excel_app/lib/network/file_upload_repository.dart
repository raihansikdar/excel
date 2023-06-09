//import 'package:excel_app/models/excel_file_model.dart';
import 'package:file_picker/file_picker.dart';

class FileUploadRepository {
  Future<String?> pickExcelFile() async {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (filePickerResult != null) {
      return filePickerResult.files.first.path;
      // return ExcelFileModel(
      //   fileName: filePickerResult.names.first ?? '',
      //   filePath: filePickerResult.files.first.path ?? '',
      //   fileType: filePickerResult.files.first.extension ?? '',
      // );
    } else {
      return null;
    }
  }
}
