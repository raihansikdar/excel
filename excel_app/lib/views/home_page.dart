import 'package:excel_app/view_model/excel_data_view_model_controller.dart';
import 'package:excel_app/views/file_uploading_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<ExcelDataViewModelController> {
  final viewModelController = Get.put(ExcelDataViewModelController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data List'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () async {
                final excelPath = await Get.to(() => FileUploadingPage());
                if (excelPath != null) {
                  viewModelController.getExcelData(excelPath: excelPath);
                }
              },
              icon: const Icon(Icons.upload_file),
            ),
          ),
        ],
      ),
      body: viewModelController.obx(
        (state) => ListView.builder(
          itemCount: state?.length,
          itemBuilder: (context, index) {
            final data = state?[index];
            return ListTile(
              title: Text(data?.name ?? ''),
              subtitle: Text(
                'Email: ${data?.email}, \nPhone Number: ${data?.phoneNumber},\nDistance: ${data?.distance}, \nPostCode: ${data?.postcode} ',
              ),
            );
          },
        ),
        onLoading: const Center(child: CircularProgressIndicator()),
        onError: (error) => Text(error ?? ''),
        onEmpty: const Center(
          child: Text(
            "No excel data found",
            style: TextStyle(
              color: Colors.amber,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
