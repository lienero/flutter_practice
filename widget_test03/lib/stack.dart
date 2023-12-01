import 'package:flutter/material.dart';

void main() {
  runApp(ColumnWidgetExample());
}

// 위젯을 가로로 배치하는 Row 위젯
class ColumnWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Scaffold(
          body: SizedBox(
            // 반대 축에서 이동할 공간을 제공하기 위해 너비를 최대한으로 설정
            width: double.infinity,
            // 위젯을 겹치는 기능을 제공
            child: Stack(
              // 넣고 싶은 위젯 입력
              children: [
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.red,
                ),
                Container(
                  height: 250,
                  width: 250,
                  color: Colors.yellow,
                ),
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        )
    );
  }
}




