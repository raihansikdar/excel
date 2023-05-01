import 'package:excel_app/models/excel_data_model.dart';
import 'package:excel_app/network/api_remote_service.dart';
import 'package:get/get.dart';

class ViewModelController extends GetxController
    with StateMixin<List<ExcelDataModel>> {
  RxList<ExcelDataModel> excelDataList = RxList();
  final ApiRemoteService apiRemoteService = ApiRemoteService();

  @override
  void onInit() {
    super.onInit();
    getExcelData();
  }

  void getExcelData() async {
    try {
      final getExcelData = await apiRemoteService.fetchExcelData();
      excelDataList.value = getExcelData;
      if (excelDataList.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(excelDataList, status: RxStatus.success());
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
  
}
