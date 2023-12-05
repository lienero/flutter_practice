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
          // 가로, 세로를 최대로 사용하기 위해 row, column을 섞음
          child: Row(
            // 가운데 정렬 추가
            mainAxisAlignment: MainAxisAlignment.center,
            // 여러 위젯을 입력할 수 있는 chidren 매개변수
            children: [
              Column(
                // 가운데 정렬 추가
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    width: 200,
                  ),
                  // 로딩 위젯
                  CircularProgressIndicator(
                    // 로딩 위젯 색 지정
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ]
              )
            ]
          ),
        )
      )
    );
  }
}

