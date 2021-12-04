import 'package:get/get.dart';
import 'package:get_x_project/models/news_model.dart';
import 'package:get_x_project/services/http_service.dart';

class SearchController extends GetxController {
  var isLoading = false.obs;
  var newsList = <Article>[].obs;

  void getList(String item) async {
    isLoading(true);
    try {
      HttpService.getSearchList(search: item).then((list) {
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
}
