import 'package:flutter/material.dart';
import 'package:random_dice/screen/home_screen.dart';
import 'package:random_dice/screen/settings_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with
// TabController를 초기화하려면 vsync 기능이 필요
// TabController에서 vsyn 사용 위해선 TickerProviderStateMixin 필수
TickerProviderStateMixin{
  TabController? controller; // 사용할 TabController 선언
  double threshold = 2.7; // 민감도 기본값 설정
  @override
  void initState() {
    super.initState();
    // 컨트롤러 초기화
    controller = TabController(length: 2, vsync: this);
    // 컨트롤러 속성이 변경될 때 마다 실행할 함수 등록
    controller!.addListener(tabListner);
  }

  // 리스너로 사용할 함수
  tabListner() {
    setState(() {});
  }

  @override
  dispose() { // dispose : 위젯이 삭제될 때 실행
    // 리스너에 등록한 함수 등록 취소
    controller!.removeListener(tabListner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView( // 탭 화면을 보여줄 위젯
        controller: controller, // 컨트롤러 등록
        children: renderChildren(),
      ),
      // 탭 네비게이션을 구현하는 매개변수
      bottomNavigationBar: renderBottomNavigation(),
    );
  }

  List<Widget> renderChildren() {
    return [
      HomeScreen(number: 1),
      SettingsScreen(
        threshold: threshold,
        onThresholdChange: onThresholdChange,
      )
    ];
  }

  // 슬라이더값 변경 시 실행 함수
  void onThresholdChange(double val) {
    setState(() {
      threshold = val;
    });
  }

  BottomNavigationBar renderBottomNavigation() {
    // 탭 네비게이션을 구현하는 위젯
    return BottomNavigationBar(
      // 현재 화면에 랜더링되는 탭의 인덱스
      currentIndex: controller!.index,
      onTap: (int index) { // 탭이 실행될 때 마다 실행되는 함수
        setState(() {
          controller!.animateTo(index); // 자연스러운 애니메이션
        });
      },
      items: [
        // 하단 탭바의 각 버튼을 구현
        BottomNavigationBarItem(
          icon: Icon(Icons.edgesensor_high_outlined,),
          label: '주사위',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '설정',
        ),
      ]
    );
  }

}