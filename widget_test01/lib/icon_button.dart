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
          child: IconButton(
            // 클릭 시 실행
            onPressed: () {},
            // 플러터에서 시본으로 제공하는 아이콘입니다.
            icon: Icon(Icons.home,),
          ),
        ),
      ),
    );
  }
}