import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

// StatefulWidget 위젯 정의
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// _HomeScreenState 정의
class _HomeScreenState extends State<HomeScreen> {
  // PageController 생성
  final PageController pageController = PageController();
  // initState() 함수 등록
  @override
  void initState() {
    // 부모 initState() 실행
    super.initState();
    // Timer.periodic() 등록
    Timer.periodic(
        Duration(seconds: 3),
        (timer) {
          // 현재 페이지 가져오기
          int? nextPage = pageController.page?.toInt();
          if (nextPage == null) { // 페이지 값이 없을 때 예외처리
            return;
          }
          if (nextPage == 4) { // 첫 페이지와 마지막 페이지 분기 처리
            nextPage = 0;
          } else {
            nextPage++;
          }
          pageController.animateToPage( // 페이지 변경
              nextPage,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // 상태바 색상 변경
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      // PAGEVIEW 추가
      body: PageView(
        // PageController 등록
        controller: pageController,
        // 샘플 리스트 생성
        children: [1,2,3,4,5].map( // 위젯으로 매핑
              (number) => Image.asset(
                  'asset/img/image_$number.jpeg',
                  // BoxFit.cover 최대한 전체 화면을 차지하도록 늘어남
                  fit: BoxFit.cover,
              ),
        ).toList(),
      ),
    );
  }
}