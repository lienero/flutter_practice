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
          // 텍스트만 있는 버튼
          child: TextButton(
            // 클릭 시 실행
            onPressed: () {},
            // 스타일 지정
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            // 버튼에 넣을 위젯
            child: Text('텍스트버튼',
            ),
          ),
        ),),
    );
  }
}