import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:provider/provider.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';

// 프로바이더로 상태를 관리하기에 statefulwidget 사용하지 않음
class HomeScreen extends StatelessWidget {
  DateTime selectedDate = DateTime.utc( // 선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    // 프로바이더 변경이 있을 때 마다 build 함수 재실행
    final provider = context.watch<ScheduleProvider>();
    // 선택된 날짜 가져오기
    final selectedDate = provider.selectedDate;
    // 선택된 날짜에 해당하는 일정들 가져오기
    final schedules = provider.cache[selectedDate] ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton( // 새 일정 버튼
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          showModalBottomSheet( // BottomSheet 열기
            context: context,
            isDismissible: true, // 배경 탭 했을 때 BottomSheet 닫기
            builder: (_) => ScheduleBottomSheet( selectedDate: selectedDate, ),
            // bottomsheet의 높이를 화면의 최대 높이로 정의
            // 스크롤이 가능하게 변경
            isScrollControlled: true
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea( // 시스템 UI 피해서 UI 구현하기
        child: Column( // 달력과 리스트를 세로로 배치
          children: [
            // 미리 작업해둔 달력 위젯 보여주기
            MainCalendar(
              selectedDate: selectedDate, // 선택된 날짜 전달하기
              // 날짜가 선택될 때 실행할 함수
              onDaySelected: (selectedDate, focusedDate) =>
                onDaySelected(selectedDate, focusedDate, context),
            ),
            SizedBox(height: 8),
            TodayBanner( // build() 함수 내부의 TodayBanner 위젯
              selectedDate: selectedDate,
              count: schedules.length,
            ),
            SizedBox(height: 8),
            Expanded( // 남는 공간 모두 차지하기
              // streambuiler를 프로바이더로 대체
              child: ListView.builder( // 화면에 보이는 값들만 렌더링하는 리스트
                // 리스트에 입력할 값들의 총 개수
                itemCount: schedules.length,
                itemBuilder: (context, index) {
                  // 현재 인덱스에 해당되는 일정
                  final schedule = schedules[index];

                  return Dismissible( // Dismissible 위젯을 사용하면 제스처 기능 지원
                    key: ObjectKey(schedule.id), // 유니크한 키값
                    // 밀기 방향(오른쪽에서 왼쪽으로)
                    direction: DismissDirection.startToEnd,
                    // 밀기 했을 때 실행할 함수
                    onDismissed: (DismissDirection direction) {
                      provider.deleteSchedule(date: selectedDate, id: schedule.id);
                    },
                    child: Padding( // 좌우로 패딩을 추가해서 ui 개선
                      padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                      child: ScheduleCard(
                        startTime: schedule.startTime,
                        endTime: schedule.endTime,
                        content: schedule.content,
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 날짜가 선택될 때 마다 실행할 함수
  void onDaySelected(
    DateTime selectedDate,
    DateTime focusedDate,
    BuildContext context,
  ) {
    final provider = context.read<ScheduleProvider>();
    provider.changeScheduleDate(date: selectedDate);
    provider.getSchedules(date: selectedDate);
  }
}