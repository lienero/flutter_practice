import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // const 생성자
  const HomeScreen({Key? key}) : super(key: key);

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
      body: Text('Home Screen'),
    );
  }
}