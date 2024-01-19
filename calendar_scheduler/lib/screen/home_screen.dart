import 'package:flutter/material.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/component/main_calendar.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/banner_ad_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:intl/intl.dart';

// 프로바이더로 상태를 관리하기에 statefulwidget 사용하지 않음
class HomeScreen extends StatefulWidget {

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
              // 날짜가 선택될 때 실행할 함수
              onDaySelected: (selectedDate, focusedDate) =>
                onDaySelected(selectedDate, focusedDate, context),
            ),
            SizedBox(height: 8),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                .collection('schedule')
                .where(
                  'date',
                  isEqualTo: '${DateFormat('yyyyMMdd').format(selectedDate)}',
                )
                .snapshots(),
              builder: (context, snapshot) {
                return TodayBanner( // build() 함수 내부의 TodayBanner 위젯
                  selectedDate: selectedDate,
                  // 개수 가져오기
                  count: snapshot.data?.docs.length ?? 0,
                );
              }
            ),
            SizedBox(height: 8),
            Expanded( // 남는 공간 모두 차지하기
              child: StreamBuilder<QuerySnapshot>( // StreamBuilder 구현하기
                // 파이어스토어로부터 일정 가져오기
                stream: FirebaseFirestore.instance
                  .collection('schedule')
                  .where(
                    'date',
                    isEqualTo: '${DateFormat('yyyyMMdd').format(selectedDate)}',
                  )
                  .snapshots(),
                builder: (context, snapshot) {
                  // Stream를 가져오는 동안 에러가 났을 때 보여줄 화면
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('일정 정보를 가져오지 못했습니다.'),
                    );
                  }

                  // 로딩 중 일때 보여줄 화면
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  
                  // ScheduleModel로 데이터 매핑하기
                  final schedules = snapshot.data!.docs.map(
                    (QueryDocumentSnapshot e) => ScheduleModel.fromJson(
                      json: (e.data() as Map<String, dynamic>),
                    )
                  ).toList();

                  return ListView.separated( // 화면에 보이는 값들만 렌더링하는 리스트
                    // 리스트에 입력할 값들의 총 개수
                    itemCount: schedules.length,
                    separatorBuilder: (context, index) {
                      return BannerAdWidget();
                    },
                    itemBuilder: (context, index) {
                      // 현재 인덱스에 해당되는 일정
                      final schedule = schedules[index];

                      return Dismissible( // Dismissible 위젯을 사용하면 제스처 기능 지원
                        key: ObjectKey(schedule.id), // 유니크한 키값
                        // 밀기 방향(오른쪽에서 왼쪽으로)
                        direction: DismissDirection.startToEnd,
                        // 밀기 했을 때 실행할 함수
                        onDismissed: (DismissDirection direction) {
                          FirebaseFirestore.instance
                            .collection('schedule')
                            .doc(schedule.id)
                            .delete();
                        },
                        child: Padding( // 좌우로 패딩을 추가해서 ui 개선
                          padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                          child: ScheduleCard(
                            // 특정 문서 삭제하기
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                          ),
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
  void onDaySelected(
    DateTime selectedDate,
    DateTime focusedDate,
    BuildContext context,
  ) {
    setState(() { // 새로운 날짜가 선택될 때마다 selectedDate값 변경해주기
      this.selectedDate = selectedDate;
    });
  }
}