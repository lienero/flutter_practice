import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PAGEVIEW 추가
      body: PageView(
        // 샘플 리스트 생성
        children: [1,2,3,4,5].map( // 위젯으로 매핑
              (number) => Image.asset(
                  'asset/img/image_$number.jpeg',
                  // BoxFit.cover 최대한 전체 화면을 차지하도록 늘어남
                  fit: BoxFit.cover,),
        ).toList(),
      ),
    );
  }
}