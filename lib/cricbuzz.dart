import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class cricbuzz extends StatefulWidget {
  const cricbuzz({Key? key}) : super(key: key);

  @override
  State<cricbuzz> createState() => _cricbuzzState();
}

class _cricbuzzState extends State<cricbuzz> {
  var loadingPercentage = 0;
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://m.cricbuzz.com'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: controller,
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
          ),
        Positioned(child: Container(
          height: MediaQuery.of(context).size.height / 5.2,
          width: MediaQuery.of(context).size.width,
          color: Colors.blue,
        ))
      ],
    );
  }
}
