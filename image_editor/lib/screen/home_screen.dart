import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'package:image_editor/component/main_app_bar.dart';
import 'package:image_editor/component/footer.dart';
import 'package:image_editor/component/emoticon_sticker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image; // 선택한 이미지를 저장할 변수
  Set<StickerModel> stickers = {}; // 화면에 추가된 스티커를 저장할 변수
  String? selectedId; // 현재 선택된 스티커의 ID
  GlobalKey imgKey = GlobalKey(); // 이미지로 전환할 위젯에 입력해줄 키값

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
      // RepaintBoundary : 수치는 낮지만 일부분의 CPU와 메모리 영역을 사용해 렌더링 최적화
      return RepaintBoundary( // 위젯을 이미지로 저장하는 데 사용
        key: imgKey,
        child: Positioned.fill( // Stack 크기의 최대 크기 만큼 차지하기
            child: InteractiveViewer( // 위젯 확대 및 좌우 이동을 가능하게 하는 위젯
                child: Stack(
                  fit: StackFit.expand, // 크기 최대로 늘려주기
                  children: [
                    Image.file(
                      File(image!.path),
                      fit: BoxFit.cover, // 이미지가 부모 위젯 크기 최대를 차지하도록 하기
                    ),
                    ...stickers.map(
                            (sticker) => Center( // 최초 스티커 선택 시 중앙에 배치
                          child: EmoticonSticker(
                            key: ObjectKey(sticker.id),
                            onTransfrom: () {
                              // 스티커의 ID값 함수의 매개변수로 전달
                              onTransform(sticker.id);
                            },
                            imgPath: sticker.imgPath,
                            isSelected: selectedId == sticker.id,
                          ),
                        )
                    )

                  ],
                )
            )
        ),
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

  void onTransform(String id) {
    // 스티커가 변형될 때마다 변형 중인
    // 스티커를 현재 선택한 스티커로 지정
    setState(() {
      selectedId = id;
    });
  }

  void onEmotcionTap(int index) async {
    setState(() {
      stickers = {
        ...stickers,
        StickerModel(
          id: Uuid().v4(), // 스티커의 고유 ID 생성
          imgPath: 'asset/img/emoticon_$index.png'
        ),
      };
    });
  }

  void onPickImage() async {
    // 갤러리에서 이미지 선택
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      this.image = image; // 선택한 이미지 저장
    });
  }

  void onSaveImage() async {
    RenderRepaintBoundary boundary = imgKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary; // 실제 화면에 렌더링된 위젯 찾기
    // 바운더리를 이미지로 변환
    ui.Image image = await boundary.toImage();
    // byteData 형태로 형태 변경
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // Uint8List 현태로 형태 변경
    Uint8List pngByte = byteData!.buffer.asUint8List();

    // 이미지 저장하기
    await ImageGallerySaver.saveImage(pngByte, quality: 100);
    ScaffoldMessenger.of(context).showSnackBar( // 저장 후 snackbar 부여주기
      SnackBar(
        content: Text('저장되었습니다!'),
      )
    );
  }

  void onDeleteImage() async {
    setState(() {
      // 현재 선택돼있는 스티커 삭제 후 Set 변환
      stickers = stickers.where((sticker) => sticker.id != selectedId).toSet();
    });
  }
}