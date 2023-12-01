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
              // 노치의 유무와 상관없이 안전한 화면에서 위젯 생성 가능
              child: SafeArea(
                // 원하는 부위만 따로 적용 가능
                top: true,
                bottom: true,
                left: true,
                right: true,
                child: Container(
                  color: Colors.red,
                  height: 300,
                  width: 300,
                ),
              )
          ),
        )
    );
  }
}

