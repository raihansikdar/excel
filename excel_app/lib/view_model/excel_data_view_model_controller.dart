import 'package:excel_app/models/excel_data_model.dart';
import 'package:excel_app/network/api_remote_service.dart';
import 'package:get/get.dart';

class ExcelDataViewModelController extends GetxController
    with StateMixin<List<ExcelDataModel>> {
  // RxList<ExcelDataModel> excelDataList = RxList();
  final ApiRemoteService apiRemoteService = ApiRemoteService();

  @override
  void onInit() {
    super.onInit();
    getExcelData();
  }

  void getExcelData({String? excelPath}) async {
    try {
      if (excelPath == null) {
        change([], status: RxStatus.empty());
        return;
      }

      final excelData = await apiRemoteService.fetchExcelData(excelPath);
      // excelDataList.value = getExcelData;

      if (excelData.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(excelData, status: RxStatus.success());
      }
    } catch (e) {
      change([], status: RxStatus.error(e.toString()));
    }
  }
}
