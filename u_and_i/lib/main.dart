import 'package:flutter/material.dart';
import 'package:u_and_i/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData( // 테마를 지정할 수 있는 클래스
        fontFamily: 'sunflower', // 기본 글씨체
        textTheme: TextTheme( // 글자 테마를 적용할 수 있는 클래스
          headline1: TextStyle( // headline1 스타일 정의
            color: Colors.white,
            fontSize: 80,
            fontWeight: FontWeight.w700,
            fontFamily: 'parisienne'
          ),
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w700
          ),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 30
          ),
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 20
          )
        )
      ),
      home: HomeScreen(),
    ),
  );
}

