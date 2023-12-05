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
    // 웹뷰가 생성됐을 때 단 한번만 실행
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
        // AppBar의 actions 매개 변수
        actions: [
          IconButton(
            // 눌렀을 때 콜백함수 설정
            onPressed: () {
              if (controller != null) {
                // 웹뷰에서 보여줄 사이트 실행하기
                // null 이 가능한 타입으로 선언됐이에 ! 기호 추가
                controller!.loadRequest(Uri.parse('https://blog.codefactory.ai'));
              }
            },
            // 홈버튼 아이콘 설정
            icon: Icon(Icons.home,),
          ),
        ],
      ),
      // Webview 추가
      body: WebViewWidget(controller: controller,),
    );
  }
}