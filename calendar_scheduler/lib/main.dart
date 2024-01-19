import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:calendar_scheduler/firebase_options.dart';

void main() async {
  // 플러터 프레임워크가 준비될 때까지 대기
  WidgetsFlutterBinding.ensureInitialized();

  // 광고 기능 초기화하기
  MobileAds.instance.initialize();

  // 파이어베이스 프로젝트 설정 함수
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  await initializeDateFormatting(); // intl 패키지 초기화(다국어화)
  
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  );
}