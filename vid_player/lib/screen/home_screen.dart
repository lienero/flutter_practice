import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video; // 동영상을 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // 동영상이 선택됐을 때와 안 됐을 때 보여줄 위젯
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  // 동영상 선택 전 보여줄 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width, // 넓이를 최대로
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(),
          SizedBox(height: 30),
          _AppName(),
        ],
      ),
    );
  }

  // 동영상 선택 후 보여줄 위젯
  Widget renderVideo() {
    return Container();
  }
}

// 로고를 보여줄 위젯
class _Logo extends StatelessWidget {
  const _Logo({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('asset/img/logo.png');
  }
}

// 앱 제목을 보여줄 위젯
class _AppName extends StatelessWidget {
  const _AppName({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          // copyWith는 현재 속성을 유지한 채 특정 속성만 변경 가능
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}