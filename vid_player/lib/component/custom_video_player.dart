import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:vid_player/component/custom_icon_button.dart';
import 'dart:io'; // 파일 관련 작업 패키지

// 동영상 위젯 생성
class CustomVideoPlayer extends StatefulWidget {
  // 선택한 동영상을 저장할 변수
  // XFile은 ImagePicker로 영상 또는 이미지를 선택했을 떄 반환하는 타입
  final XFile video;
  // 새로운 동영상을 선택하면 실행되는 함수
  final GestureTapCallback onNewVideoPressed;

  const CustomVideoPlayer({
    required this.video, // 상위에서 선택한 동영상 주입해주기
    required this.onNewVideoPressed,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  bool showControls = false; // 동영상 조작하는 아이콘을 보일지 여부
  // 동영상을 조작하는 컨트롤러
  VideoPlayerController? videoController;

  // covariant 키워드는 CustomVideoPlayer 클래스의 상속된 값도 허가해줍니다.
  // oldWidget은 폐기되는 위젯을 의미함
  // didUpdateWidget(). 부모 위젯이 재 빌드되어 위젯이 갱신될 때 호출된다.
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // 새로 선택한 동영상이 같은 동영상인지 확인
    if (oldWidget.video.path != widget.video.path) {
      initializeController();
    }
  }

  @override
  void initState() {
    super.initState();
    initializeController(); // 컨트롤러 초기화
  }

  // 선택한 동영상으로 컨트롤러 초기화
  initializeController() async {
    final videoController = VideoPlayerController.file(File(widget.video.path));

    await videoController.initialize();

    // 컨트롤러 속성이 변경 될 떄마다 실행할 함수 등록
    videoController.addListener(videoControllerListner);

    setState(() {
      this.videoController = videoController;
    });
  }

  // 동영상의 재생 상태가 변경될 때마다
  // setState() 실행해서 build를 재실행합니다.
  void videoControllerListner() {
    setState(() {
    });
  }

  // State가 폐기될 떄 같이 폐기할 함수들을 실행합니다.
  // addListener 함수를 싱행하면 꼭 dispose 함수에서 removeListner를 실행해 리소스 최적화
  @override
  void dispose() {
    // Listenr 삭제
    videoController?.removeListener(videoControllerListner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 동영상 컨트롤러가 준비 중일 때 로딩 표시
    if (videoController == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GestureDetector( // 화면 전체의 탭을 인식하기 위해 사용
      onTap: () {
        setState(() {
          showControls = !showControls;
        });
      },
      child: AspectRatio( // 동영상 비율에 따른 화면 렌더링
        aspectRatio: videoController!.value.aspectRatio,
        child: Stack( // chidren 위젯을 위로 쌓을 수 있는 위젯
          children: [
            VideoPlayer(videoController!),
            if (showControls)
              Container(color: Colors.black.withOpacity(0.5)),
            Positioned( // child 위젯 위치를 정할 수 있는 위젯
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    renderTimeTextFromDuration(
                      // 동영상 현재 위치
                      videoController!.value.position,
                    ),
                    Expanded( // child 요소를 렌더링 영역의 최대 사이즈
                      child: Slider(
                        onChanged: (double val) { // 슬라이더가 이동할 때 마다 실행
                          videoController!.seekTo( // seekTo함수는 동영상의 재생 위치를 특정 위치로 이동
                              Duration(seconds: val.toInt())
                          );
                        },
                        // 동영상 재생 위치를 초 단위로 표현
                        value: videoController!.value.position.inSeconds.toDouble(),
                        min: 0,
                        // max 매개변수에는 double 값을 입력해야함
                        max: videoController!.value.duration.inSeconds.toDouble(),
                      ),
                    ),
                    // 동영상 총 길이
                    renderTimeTextFromDuration(videoController!.value.duration,)
                  ],
                ),
              )
            ),
            if (showControls)
              Align( // 오른쪽 위에 새 동영상 아이콘 위치
                alignment: Alignment.topRight,
                child: CustomIconButton(
                  // 카메라 아이콘을 선택하면 새로운 동영상 선택 함수 실행
                  onPressed: widget.onNewVideoPressed,
                  iconData: Icons.photo_camera_back,
                ),
              ),
            if (showControls)
              Align( // 동영상 재생 관련 아이콘 중앙에 위치
                alignment: Alignment.center,
                child: Row(
                  // spaceEvenly : 아이콘 간격을 동일하게 설정
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIconButton( // 되감기 버튼
                      onPressed: onReversePressed,
                      iconData: Icons.rotate_left,
                    ),
                    CustomIconButton( // 재생 버튼
                      onPressed: onPlayPressed,
                      iconData: videoController!.value.isPlaying ?
                      Icons.pause : Icons.play_arrow,
                    ),
                    CustomIconButton( // 앞으로 감기 버튼
                      onPressed: onForwardPressed,
                      iconData: Icons.rotate_right,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget renderTimeTextFromDuration(Duration duration) {
    // Duration값을 보기 편한 형태로 변환하기
    return Text(
      '${duration.inMinutes.toString().padLeft(2, '0')}:'
      '${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
      style: TextStyle(color: Colors.white),
    );
  }

  // 되감기 버튼을 눌렀을 때 실행할 함수
  void onReversePressed() {
    final currentPosition = videoController!.value.position; // 현재 실행 중 위치

    Duration position = Duration(); // 0초로 실행 위치 초기화

    // 현재 실행 위치가 3초보다 길 때만 3초 빼기
    if (currentPosition.inSeconds > 3) {
      position = currentPosition - Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  // 앞으로 감기 버튼 눌렀을 때 실행할 함수
  void onForwardPressed() {
    final maxPosition = videoController!.value.duration; // 동영상 길이
    final currentPosition = videoController!.value.position;

    Duration position = maxPosition; // 동영상 길이로 실행 위치 초기화

    // 동영상 길이에서 3초를 뺀 값보다 현재 위치가 짧을 때만 3초 더하기
    if ((maxPosition - Duration(seconds: 3)).inSeconds > currentPosition.inSeconds) {
      position = currentPosition + Duration(seconds: 3);
    }

    videoController!.seekTo(position);
  }

  // 재생 버튼을 눌렀을 때 실행할 함수
  void onPlayPressed() {
    if (videoController!.value.isPlaying) {
      videoController!.pause();
    } else {
      videoController!.play();
    }
  }
}