import 'package:flutter/material.dart';

void main() {
  // SplashScreen 위젯을 첫 화면으로 지정
  runApp(SplashScreen());
}

// SplashScreen 클래스 선언
class SplashScreen extends StatelessWidget {
  // 위젯의 ui 구현
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // 항상 최상단에 입력되는 위젯
      home: Scaffold( // 항상 두번째로 입력되는 위젯
        body: Container( // 컨테이너 위젯
          // 컨테이너를 디자인하는 클래스
          decoration: BoxDecoration(color: Color(0xFFF99231)),
          // 중앙 정렬 위젯
          child: Center(
            // 글자를 화면에 보여주는 위젯
            child: Image.asset('assets/logo.png'),
          ),
        )
      )
    );
  }
}

