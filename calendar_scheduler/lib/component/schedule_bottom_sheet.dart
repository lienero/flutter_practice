import 'package:flutter/material.dart';
import 'package:calendar_scheduler/component/custom_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedDate; // 선택된 날짜 상위 위젯에서 입력받기

  const ScheduleBottomSheet({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey(); // 폼 ket 생성

  int? startTime; // 시작 시간 저장 변수
  int? endTime; // 종료 시간 저장 변수
  String? content; // 일정 내용 저장 변수

  @override
  Widget build(BuildContext context) {
    // 키보드 높이 가져오기
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Form(
      key: formKey,
      child: SafeArea(
          child: Container(
              // 화면의 반을 차지 + 키보드 높이
              height: MediaQuery.of(context).size.height / 2 + bottomInset,
              color: Colors.white,
              child: Padding(
                // const 를 붙이려면 변수가 없어야 함
                padding: EdgeInsets.only(
                    left: 8, right: 8, top: 8, bottom: bottomInset),
                child: Column(
                  // 시간 관련 텍스트 필드와 내용 관련 텍스트 필드 세로로 배치
                  children: [
                    Row(
                      // 시작 시간 종료 시간 가로로 배치
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: '시작 시간', // 시작 시간 텍스트 필드 렌더링
                            isTime: true,
                            onSaved: (String? val) {
                              startTime = int.parse(val!);
                            },
                            validator: timeValidator,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            // 종료 시간 입력 필드
                            label: '종료 시간',
                            isTime: true,
                            onSaved: (String? val) {
                              endTime = int.parse(val!);
                            },
                            validator: timeValidator,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Expanded(
                      child: CustomTextField(
                        // 내용 입력 필드
                        label: '내용',
                        isTime: false,
                        onSaved: (String? val) {
                          content = val;
                        },
                        validator: contentValidator,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        // 저장 버튼
                        onPressed: () => onSavePressed(context), // 저장 함수
                        style: ElevatedButton.styleFrom(
                          primary: PRIMARY_COLOR,
                        ),
                        child: Text('저장'),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }

  void onSavePressed(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // 폼 검증하기
      formKey.currentState!.save(); // 폼 저장하기

      // 스케줄 모델 생성하기
      final schedule = ScheduleModel(
        id: Uuid().v4(),
        content: content!,
        date: widget.selectedDate,
        startTime: startTime!,
        endTime: endTime!,
      );

      // 스케쥴 모델 파이어스토어에 삽입하기
      await FirebaseFirestore.instance
          .collection('schedule')
          .doc(schedule.id)
          .set(schedule.toJson());

      Navigator.of(context).pop(); // 일정 생성 후 화면 뒤로 가기
    }
  }

  // 시간값 검증
  String? timeValidator(String? val) {
    if (val == null) {
      return '값을 입력해주세요';
    }

    int? number;

    try {
      number = int.parse(val);
    } catch (e) {
      return '숫자를 입력해주세요';
    }

    if (number < 0 || number > 24) {
      return '0시부터 24시 사이를 입력해주세요';
    }

    return null;
  }

  // 내용값 검증
  String? contentValidator(String? val) {
    if (val == null || val.length == 0) {
      return '값을 입력해주세요';
    }

    return null;
  }
}
