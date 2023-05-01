import 'package:get/get.dart';

class StateController extends GetxController {
  var isLoading = false.obs;

  void setLoading(bool loading) {
    isLoading.value = loading;
  }
}
