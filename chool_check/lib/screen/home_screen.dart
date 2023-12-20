import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatelessWidget {
  static final LatLng companyLatLng = LatLng( // 지도 초기화 위치
    37.5233273, // 위도
    126.921252, // 경도
  );

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (context, snapshot) {
          // 로딩 상태
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // 권한 허가된 상태
          if (snapshot.data == '위치 권한이 허가 되었습니다.') {
            return Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GoogleMap( // 2/3만큼 공간 차지
                    initialCameraPosition: CameraPosition(
                        target: companyLatLng,
                        zoom: 16 // 확대 정도 (높을수록 크게 보임)
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon( // 시계 아이콘
                          Icons.timelapse_outlined,
                          color: Colors.blue,
                          size: 50,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton( // [출근하기] 버튼
                          onPressed: () {},
                          child: Text('출근하기!'),
                        )
                      ],
                    )
                )
              ],
            );
          }

          // 권한 없는 상태
          return Center(
            child: Text(
              snapshot.data.toString(),
            ),
          );
        },
      )
    );
  }

  // AppBar 구현 함수
  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        '오늘도 출첵',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<String> checkPermission() async {
    // 위치 서비스 활성화 여부 확인
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    
    // 위치 서비스 활성화 안됨
    if (!isLocationEnabled) {
      return '위치 서비스를 활성화해주세요.';
    }

    // 위치 권한 확인
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    
    // 위치 권한 거절됨
    if (checkedPermission == LocationPermission.denied) {
      // 위치 권한 요청하기
      checkedPermission = await Geolocator.requestPermission();
      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요.';
      }
    }
    
    // 위치 권한 거절됨(앱에서 재요청 불가)
    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 설정에서 허가해주세요.';
    }
    
    // 위 모든 조건이 통과되면 위치 권한 허가 완료
    return '위치 권한이 허가 되었습니다.';
  }
}