import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            _DDay(),
            _CoupleImage(),
          ],
        ),
      ),
    );
  }
}

// 첫 글자가 언더스코어면 다른 파일에서 접근할 수 없음
class _DDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(height: 16),
        Text('U&I', style: textTheme.headline1,),
        const SizedBox(height: 16),
        Text('우리 처음 만난 날', style: textTheme.bodyText1,),
        Text('2021.11.23', style: textTheme.bodyText2,),
        const SizedBox(height: 16),
        IconButton(
            iconSize: 60,
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            )
        ),
        const SizedBox(height: 16),
        Text('D+365', style: textTheme.headline2,),
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
