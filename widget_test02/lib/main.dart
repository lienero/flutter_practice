import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // Container: 다른 위젯을 담는 데 사용되는 위젯
          child: Container(
            // 스타일 적용
            decoration: BoxDecoration(
              // 배경 색깔 적용
              color: Colors.red,
              // 테두리 적용
              border: Border.all(
                // 테두리 굵기
                width: 16,
                // 테두리 색상
                color: Colors.black,
              ),
              // 모서리 둥글게 만들기
              borderRadius: BorderRadius.circular(16,)
            ),
            height: 200,
            width: 100,
          )
        ),
      )
    );
  }
}

