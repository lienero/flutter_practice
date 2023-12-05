import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  // const 생성자
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 컨트롤러 변수 생성
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://blog.codefactory.ai'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // 앱바 위젯 추가
        // 배경색 지정
        backgroundColor: Colors.orange,
        // 앱 타이틀 설정
        title: Text('Code Factory'),
        // 가운데 정렬
        centerTitle: true, 
      ),
      // Webview 추가
      body: WebViewWidget(controller: controller,),
    );
  }
}