import 'dart:io';

import 'package:excel/excel.dart';
import 'package:excel_app/models/excel_data_model.dart';
import 'package:excel_app/network/api_repository.dart';

class ApiRemoteService extends ApiRepository {

  @override
  Future<List<ExcelDataModel>> fetchExcelData(String excelPath) async {
  
    final excelDataList = <ExcelDataModel>[];
    final fileBytes = await File(excelPath).readAsBytes();
    final excel = Excel.decodeBytes(fileBytes);

    for (final sheet in excel.sheets.values) {
      for (final row in sheet.rows) {
        String name = '';

        if (row.length == 1) {
          name = row[0]?.value ?? '';
        }

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
            postcode: postcode.toString(),
          ),
        );
      }
    }
    return excelDataList;
  }
}
