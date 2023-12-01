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
            // 위젯을 새로로 배치
            child: Column(
              // 주축 정렬 지정
              mainAxisAlignment: MainAxisAlignment.start,
              // 반대축 정렬 지정
              crossAxisAlignment: CrossAxisAlignment.center,
              // 넣고 싶은 위젯 입력
              children: [
                // Expanded를 사용하면 남아있는 공간을 최대한으로 차지합니다.
                Expanded(
                  child: Container(color: Colors.blue,),
                ),
                Expanded(
                  child: Container(color: Colors.red,),
                ),
              ],
            ),
          ),
        )
    );
  }
}




