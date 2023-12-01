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
              // 일정 크기의 공간을 공백으로 두고 싶을 때 사용
              child: SizedBox(
                height: 200,
                width: 200,
                // sizedbox에는 색상이 없으므로 크기를 확인하는 용도로 container 추가
                child: Container(color: Colors.red,
                ),
              )
          ),
        )
    );
  }
}

