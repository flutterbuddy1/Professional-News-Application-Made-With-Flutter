import 'package:get/get.dart';

class NewsController extends GetxController {
  var progress = 0.obs;

  void updateProgress(int prog) {
    progress(prog);
  }
}
