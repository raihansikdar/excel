import 'package:excel_app/view_model/excel_file_uploaing_view_model.dart';
import 'package:excel_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileUploadingPage extends StatelessWidget {
  final _excelFileUploadingViewModel = Get.put(ExcelFileUploadingViewModel());

  // final StateController _stateController = StateController();

  FileUploadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("file upload"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/uploading_image.png"),
                  ),
                ),
              ),
              onTap: () {
                _excelFileUploadingViewModel.uploadExcelFile();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _excelFileUploadingViewModel.obx(
              (state) {
                return Text(
                  "$state",
                  textAlign: TextAlign.center,
                );
              },
              onEmpty: const SizedBox.shrink(),
              onError: (error) => Text(error ?? ""),
              onLoading: const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 20,
            ),
            GetBuilder<ExcelFileUploadingViewModel>(
              builder: (controller) {
                return ElevatedButton(
                  onPressed: controller.state == null
                      ? null
                      : () {
                          Get.back(result: controller.state);
                        },
                  child: const Text("Extract Data"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
