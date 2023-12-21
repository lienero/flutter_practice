import 'package:flutter/material.dart';
import 'package:image_editor/component/main_app_bar.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image; // 선택한 이미지를 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // 스크린에 Body, AppBar, Footer 순서로 쌓을 준비
        fit: StackFit.expand, // 자식 위젯들 최대 크기로 펼치기
        children: [
          Positioned( // MainAppBar를 좌, 우, 위 끝에 정렬
            top: 0,
            left: 0,
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteImage: onDeleteImage,
            ),
          ),
        ],
      ),
    );
  }

  void onPickImage() async {
    // 갤러리에서 이미지 선택
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      this.image = image; // 선택한 이미지 저장
    });
  }

  void onSaveImage() {}

  void onDeleteImage() {}
}