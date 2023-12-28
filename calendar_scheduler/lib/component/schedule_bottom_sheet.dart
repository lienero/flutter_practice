import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  @override
  Widget build(BuildContext context) {
    // 키보드 높이 가져오기
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Container(
        // 화면의 반을 차지 + 키보드 높이
        height: MediaQuery.of(context).size.height / 2 + bottomInset,
        color: Colors.white,
        child: Padding(
          // const 를 붙이려면 변수가 없어야 함
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
          child: Column( // 시간 관련 텍스트 필드와 내용 관련 텍스트 필드 세로로 배치
            children: [
              Row( // 시작 시간 종료 시간 가로로 배치
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: '시작 시간', // 시작 시간 텍스트 필드 렌더링
                      isTime: true,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField( // 종료 시간 입력 필드
                      label: '종료 시간',
                      isTime: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: CustomTextField( // 내용 입력 필드
                  label: '내용',
                  isTime: false,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton( // 저장 버튼
                  onPressed: onSavePressed, // 저장 함수
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                  child: Text('저장'),
                ),
              )
            ],
          ),
        )
      )
    );
  }

  void onSavePressed() {

  }
}