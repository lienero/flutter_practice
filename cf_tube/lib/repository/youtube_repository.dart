import 'package:cf_tube/const/api.dart';
import 'package:cf_tube/model/video_model.dart';
import 'package:dio/dio.dart';

class YoutubeRespository {
  static Future<List<VideoModel>> getVideos() async {
    // Dio : http 처럼 서버와 통신을 하기 위해 필요한 패키지
    final resp = await Dio().get( // GET 메서드 보내기
      YOUTUBE_API_BASE_URL, // 요청을 보낼 URL
      queryParameters: { // 요청에 포함할 쿼리 변수들
        'channelId' : CF_CHANNEL_ID,
        'maxResults': 50,
        'key' : API_KEY,
        'part': 'snippet',
        'order': 'date',
      },
    );

    final listWithData = resp.data['items'].where(
      (item) =>
        item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    ); // videoId와 title이 null이 아닌 값들만 필터링

    return listWithData
      .map<VideoModel>(
        (item) => VideoModel(
          id: item['id']['videoId'],
          title: item['snippet']['title'],
        )
      ).toList(); // 필터링 된 값들을 기반으로 VideoModel 생성
  }
}
