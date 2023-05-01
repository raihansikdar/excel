import 'package:excel_app/view_model/excel_file_uploaing_view_model.dart';
import 'package:excel_app/view_model/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FileUploadingPage extends StatelessWidget {
  final ExcelFileUploadingViewModel _excelFileUploadingViewModel =
      ExcelFileUploadingViewModel();

  final StateController _stateController = StateController();

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
            Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/uploading_image.png"),
                  opacity: .3,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                _stateController.setLoading(true);
                _excelFileUploadingViewModel.uploadExcelFile().then((value) {
                  _stateController.setLoading(false);
                });
              },
              child: const Text("Upload File"),
            ),
            Obx(() {
              if (_stateController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (_excelFileUploadingViewModel.state is Rx<Error>) {
                return Text(
                    (_excelFileUploadingViewModel.state as Rx<Error>).value.toString());
              } else if (_excelFileUploadingViewModel.state != null) {
                final file = _excelFileUploadingViewModel.state!;
                final fileName = file.map((file) => file.fileName!).join(", ");
                return Text("$fileName uploaded successfully!");
              } else {
                return const SizedBox.shrink();
              }
              
            })
          ],
        ),
      ),
    );
  }
}
