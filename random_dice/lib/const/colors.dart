import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF0E0E0E);
const primaryColor = Colors.white; // 주색상
// 600이라는 키값을 입력하면 런타임에 색상이 계산되기 때문에 const 사용 불가
final secondaryColor = Colors.grey[600]; // 보조 색상 