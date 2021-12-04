import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_x_project/controller/home_controller.dart';
import 'package:get_x_project/models/news_model.dart';
import 'package:get_x_project/news.dart';
import 'package:get_x_project/search.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(HomeController());
    final _scrollController = ScrollController();
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.cyan, primarySwatch: Colors.cyan),
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            title: const Text("NewsGetX"),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(Search());
                  },
                  icon: Icon(Icons.search)),

              IconButton(
                  onPressed: () {
                    Get.defaultDialog(
                        title: "Developed And Designed By ❤️ Mayank",
                        middleText: "Follow us on Github : codeking5");
                  },
                  icon: Icon(Icons.more_vert)),
              // Obx(() => Switch(
              //     value: _controller.isDark.value,
              //     thumbColor:
              //         MaterialStateColor.resolveWith((states) => Colors.cyan),
              //     onChanged: (v) {
              //       _controller.changeTheme(v);
              //       if (v) {
              //         Get.changeTheme(ThemeData.dark());
              //       } else {
              //         Get.changeTheme(ThemeData.light());
              //       }
              //     }))
            ],
          ),
          body: Column(
            children: [
              Container(
                height: Get.height * 0.1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    itemCount: _controller.categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: GetX<HomeController>(
                          init: HomeController(),
                          initState: (_) {},
                          builder: (_) {
                            return Chip(
                                // ignore: unrelated_type_equality_checks
                                backgroundColor:
                                    _controller.categories[index] ==
                                            _controller.activeCategory.value
                                        ? Colors.cyan
                                        : null,
                                label: InkWell(
                                  onTap: () {
                                    _controller.changeCategory(
                                        _controller.categories[index]);
                                    _scrollController.animateTo(0,
                                        duration: Duration(milliseconds: 100),
                                        curve: Curves.easeInOut);
                                  },
                                  child: Text(_controller.categories[index]
                                      .toUpperCase()),
                                ));
                          },
                        ),
                      );
                    }),
              ),
              Expanded(
                child: Obx(() {
                  if (_controller.isLoading.value == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      primary: false,
                      controller: _scrollController,
                      itemCount: _controller.newsList.length,
                      itemBuilder: (context, _) {
                        Article article = _controller.newsList[_];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                                News(title: article.title, url: article.url));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  margin: const EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
                                            color: Colors.black45,
                                            blurRadius: 10)
                                      ],
                                      borderRadius: BorderRadius.circular(10)),
                                  child: CachedNetworkImage(
                                    height: 200,
                                    width: Get.width * 0.9,
                                    // ignore: prefer_if_null_operators
                                    imageUrl: article.urlToImage != null
                                        ? article.urlToImage
                                        : "https://via.placeholder.com/400x250?text=${article.author}",
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 60,
                                  padding: const EdgeInsets.all(5),
                                  width:
                                      MediaQuery.of(context).size.width * 0.935,
                                  child: Text(
                                    article.title,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }),
              ),
            ],
          ),
        ));
  }
}
