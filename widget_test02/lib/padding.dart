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
            // 최상위 검정 컨테이너 (margin이 적용되는 대상)
              child: Container(
                color: Colors.black,
                // 중간 파랑 컨테이너
                child: Container (
                  color: Colors.blue,
                  // 바깥에 간격을 추가하는 마직 적용
                  margin: EdgeInsets.all(16),
                  child: Padding(
                  // 상하, 좌우로 모두 16픽셀만큼 패딩 적용
                  padding: EdgeInsets.all(
                    16,
                  ),
                  // 패딩이 적용된 빨강 컨테이너
                  child: Container(
                    color: Colors.red,
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}

