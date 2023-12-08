import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime firstDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      // 시스템 UI 피해서 UI 그리기
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          // 위 아래 끝에 위젯 배치
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // 반대축 최대 크기로 늘리기
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(
              // 하트를 눌렀을 때 실행할 함수 전달하기
              onHeartPressed: onHeartPressed,
              firstDay: firstDay,
            ),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
  // 하트를 눌렀을 때 실행할 함수
  void onHeartPressed() {
    // setState() : 상태 변경하는 함수
    setState(() {
      // firstDay 변수에서 하루 빼기
      // subtract() : 원하는 만큼 기간을 뺴는 함수, Duration으로 기간을 정하고 사용
      firstDay = firstDay.subtract(Duration(days: 1));
    });
  }
}

// 첫 글자가 언더스코어면 다른 파일에서 접근할 수 없음
class _DDay extends StatelessWidget {
  // 하트를 눌렀을 때 실행할 함수
  final GestureTapCallback onHeartPressed;
  // 사귀기 시작한 날
  final DateTime firstDay;

  _DDay({
    // 상위에서 함수 입력받기
    required this.onHeartPressed,
    required this.firstDay,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();
    return Column(
      children: [
        const SizedBox(height: 16),
        Text('U&I', style: textTheme.headline1,),
        const SizedBox(height: 16),
        Text('우리 처음 만난 날', style: textTheme.bodyText1,),
        Text(
          '${firstDay.year}.${firstDay.month}.${firstDay.day}',
          style: textTheme.bodyText2,
        ),
        const SizedBox(height: 16),
        IconButton(
            iconSize: 60,
            onPressed: onHeartPressed, // 아이콘 눌렀을 때 실행할 함수
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            )
        ),
        const SizedBox(height: 16),
        // D-DAY
        Text(
          'D+${DateTime(now.year, now.month, now.day)
              .difference(firstDay).inDays + 1}', // D-DAY 계산
          style: textTheme.headline2,
        ),
      ],
    );
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 이미지가 남는 공간만큼 차지하도록 Expanded 위젯 사용
    return Expanded(
      child: Center(
        child: Image.asset(
          'asset/img/middle_image.png',
          // MediaQuery.of(context) : 화면 크기와 관련된 각종 기능을 사용
          // of(context) : 현재 위젯 트리에 있는 가장 가까이에 있는 MediaQuery 값
          // 화면의 반만큼 높이 구현
          // Expandend가 우선 순위를 갖게 되어 무시됨
          height: MediaQuery.of(context).size.height / 2,),
      )
    );
  }
}
