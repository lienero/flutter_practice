import 'package:cf_tube/component/custom_youtube_player.dart';
import 'package:cf_tube/model/video_model.dart';
import 'package:cf_tube/repository/youtube_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true, // 제목 가운데 정렬
        title: Text('코팩튜브'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRespository.getVideos(), // 유튜브 영상 가져오기
        builder: (context, snapshot) {
          if (snapshot.hasError) { // 에러가 있을 경우 에러 화면에 표시
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) { // 로딩 중일때 로딩 위젯 보여주기
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return RefreshIndicator( // 새로고침 기능이 있는 위젯
            onRefresh: () async {
              setState(() {});
            },
            child: ListView( // List<VideoModel>을 CustomYotubePlayer로 매핑
              // 아래로 당겨서 스크롤할 떄 튕기는 애니메이션 추가
              physics: BouncingScrollPhysics(),
              children: snapshot.data!
                  .map((e) => CustomYoutubePlayer(videoModel: e))
                  .toList(),
            ),
          ) ;
        }
      )
    );
  }
}