import 'package:flutter/material.dart';
import 'package:image_editor/component/main_app_bar.dart';
import 'package:image_editor/component/footer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
          renderBody(),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: MainAppBar(
              onPickImage: onPickImage,
              onSaveImage: onSaveImage,
              onDeleteImage: onDeleteImage,
            ),
          ),
          if (image != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Footer(
                onEmotcionTap: onEmotcionTap,
              )
            )
        ],
      ),
    );
  }

  Widget renderBody() {
    if (image != null) {
      return Positioned.fill( // Stack 크기의 최대 크기 만큼 차지하기
          child: InteractiveViewer( // 위젯 확대 및 좌우 이동을 가능하게 하는 위젯
            child: Image.file(
              File(image!.path),
              fit: BoxFit.cover, // 이미지가 부모 위젯 크기 최대를 차지하도록 하기
            ),
          )
      );
    } else {
      return Center( // 이미지 선택이 안 된 경우 이미지 선택 버튼 표시
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text('이미지 선택하기'),
        ),
      );
    }
  }

  void onEmotcionTap(int index) {}

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