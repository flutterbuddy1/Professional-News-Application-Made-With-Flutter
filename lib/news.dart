import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_project/controller/news_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class News extends StatelessWidget {
  News({Key? key, required this.title, required this.url}) : super(key: key);
  String title;
  String url;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final _newsControler = Get.put(NewsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (_newsControler.progress.value == 100) {
              return SizedBox();
            } else {
              return Container(
                height: 5,
                width: _newsControler.progress.value * 10,
                decoration: BoxDecoration(color: Colors.red),
              );
            }
          }),
          Expanded(
              child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onProgress: (int progress) {
              _newsControler.updateProgress(progress);
            },
          ))
        ],
      ),
    );
  }
}
