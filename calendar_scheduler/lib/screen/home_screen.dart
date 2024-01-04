import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/database/drift_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc( // 선택된 날짜를 관리할 변수
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
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
              onDaySelected: onDaySelected, // 날짜가 선택될 때 실행할 함수
            ),
            SizedBox(height: 8),
            TodayBanner(
              selectedDate: selectedDate,
              count: 0
            ),
            SizedBox(height: 8),
            Expanded( // 남는 공간 모두 차지하기
              // 일정 정보가 stream으로 제공되기 때문에 streambuiler 사용
              child: StreamBuilder<List<Schedule>>(
                stream: GetIt.I<LocalDatabase>().watchScedules(selectedDate),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) { // 데이터가 없을 때
                    return Container();
                  }
                  return ListView.builder( // 화면에 보이는 값들만 렌더링하는 리스트
                    // 리스트에 입력할 값들의 총 개수
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      // 현재 인덱스에 해당되는 일정
                      final schedule = snapshot.data![index];
                      return Padding( // 좌우로 패딩을 추가해서 ui 개선
                        padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                        child: ScheduleCard(
                          startTime: schedule.startTime,
                          endTime: schedule.endTime,
                          content: schedule.content,
                        ),
                      );
                    }
                  );
                },
              )
            ),
          ],
        ),
      ),
    );
  }

  // 날짜가 선택될 때 마다 실행할 함수
  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}