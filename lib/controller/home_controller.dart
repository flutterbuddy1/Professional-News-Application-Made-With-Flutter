import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:get_x_project/models/news_model.dart';
import 'package:get_x_project/services/http_service.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var newsList = <Article>[].obs;
  var categories = [
    "general",
    "business",
    "entertainment",
    "health",
    "science",
    "sports",
    "technology"
  ];

  var activeCategory = "general".obs;

  var isDark = false.obs;

  @override
  void onInit() {
    super.onInit();
    getList();
  }

  void getList() async {
    isLoading(true);
    try {
      HttpService.getNewsList(category: activeCategory.value).then((list) {
        if (list != null) {
          newsList.assignAll(list);
          isLoading(false);
        }
      });
    } catch (e) {
      print(e);
      isLoading(true);
    }
  }

  void changeCategory(String category) {
    activeCategory(category);
    getList();
  }

  void changeTheme(bool value) {
    isDark(value);
  }
}
