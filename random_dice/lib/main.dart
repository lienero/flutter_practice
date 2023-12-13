import 'package:random_dice/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:random_dice/const/colors.dart';


void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        // Slider 위젯 관련 테마
        sliderTheme: SliderThemeData(
          thumbColor: primaryColor, // 노브 색상
          activeTickMarkColor: primaryColor, // 노브 이동한 트랙 색상
          // 노브가 아직 이동하지 않은 트랙 색상
          inactiveTickMarkColor: primaryColor.withOpacity(0.3),
        ),
        // bottomNavigationBarTheme 위젯 관련 테마
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor, // 선택 색상
          unselectedItemColor: secondaryColor, // 비선택 색상
          backgroundColor: backgroundColor,
        )
      ),
      home: HomeScreen(),
    )
  );
}