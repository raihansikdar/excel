import 'package:excel/excel.dart';
import 'package:excel_app/models/excel_data_model.dart';
import 'package:excel_app/network/api_repository.dart';
import 'package:flutter/services.dart';

class ApiRemoteService extends ApiRepository {
  
  @override
  Future<List<ExcelDataModel>> fetchExcelData() async {
    final ByteData loadExcelData = await rootBundle.load('assets/DL.xlsx');
    final Uint8List makeExcelDatabytes = loadExcelData.buffer.asUint8List();
    final excel = Excel.decodeBytes(makeExcelDatabytes);

    final sheetName = excel.tables['Sheet'];
    final excelDataList = <ExcelDataModel>[];

    if (sheetName != null) {
      for (var row in sheetName.rows) {
        final name = row[0]?.value ?? '';
        final email = row[1]?.value ?? '';
        final phoneNumber = row[2]?.value ?? '';
        final distance = row[3]?.value ?? '';
        final postcode = row[4]?.value ?? '';

        excelDataList.add(
          ExcelDataModel(
              name: name.toString(),
              email: email.toString(),
              phoneNumber: phoneNumber.toString(),
              distance: distance.toString(),
              postcode: postcode.toString()),
        );
      }
    } else {
      throw Exception("Sheet not found");
    }

    return excelDataList;
  }
}
