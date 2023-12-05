import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Home Screen'),
    );
  }
}

// 첫 글자가 언더스코어면 다른 파일에서 접근할 수 없음
class _DDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('DDay Widget');
  }
}

class _CoupleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Couple Image Widget');
  }
}
