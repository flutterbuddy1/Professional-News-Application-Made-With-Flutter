import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_x_project/controller/search_controller.dart';
import 'package:get_x_project/models/news_model.dart';
import 'package:get_x_project/news.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(SearchController());
    return Scaffold(
      appBar: AppBar(
          title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.black38, borderRadius: BorderRadius.circular(2)),
        child: TextField(
          onSubmitted: (text) {
            _controller.getList(text);
          },
          textInputAction: TextInputAction.search,
          autofocus: true,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration:
              InputDecoration(border: InputBorder.none, hintText: "Search..."),
        ),
      )),
      body: Obx(() {
        if (_controller.isLoading.value != false) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView.builder(
              itemCount: _controller.newsList.length,
              itemBuilder: (context, index) {
                Article article = _controller.newsList[index];
                return ListTile(
                  onTap: () {
                    Get.to(News(title: article.title, url: article.url));
                  },
                  leading: CachedNetworkImage(
                      // ignore: prefer_const_constructors
                      placeholder: (c, _) => Image(
                          height: 50,
                          width: 80,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/img/loading.jpg")),
                      height: 50,
                      width: 80,
                      fit: BoxFit.cover,
                      imageUrl: article.urlToImage),
                  title: Text(article.title),
                );
              }),
        );
      }),
    );
  }
}
