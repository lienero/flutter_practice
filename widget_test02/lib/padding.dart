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
                color: Colors.blue,
                child: Padding(
                  // 상하, 좌우로 모두 16픽셀만큼 패딩 적용
                  padding: EdgeInsets.all(
                    16,
                  ),
                  child: Container(
                    color: Colors.red,
                    width: 50,
                    height: 50,
                  ),
                ),
              )
          ),
        )
    );
  }
}

