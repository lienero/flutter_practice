import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // 입체적으로 튀어나온 느낌의 배경이 들어간 버튼
          child: ElevatedButton(
            // 클릭 시 실행
            onPressed: () {},
            // 스타일 지정
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            // 버튼에 넣을 위젯
            child: Text('엘레베이티드 버튼'),
          ),
        ),
      ),
    );
  }
}