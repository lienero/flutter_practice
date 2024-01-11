import 'package:calendar_scheduler/model/schedule_model.dart';
import 'package:calendar_scheduler/repository/schedule_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleRepository repository; // Api요청 로직을 담은 클래스

  DateTime selectedDate = DateTime.utc( // 선택한 날짜
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Map<DateTime, List<ScheduleModel>> cache = {}; // 일정 정보를 저장해둘 변수

  ScheduleProvider({
    required this.repository,
  }) : super() {
    getSchedules(date: selectedDate);
  }

  void getSchedules({
    required DateTime date,
  }) async {
    // GET 메서드 보내기
    final resp = await repository.getSchedules(date: date);
    // 선택된 날짜의 일정들 업데이트 하기
    cache.update(date, (value) => resp, ifAbsent: () => resp);
    notifyListeners(); // 리슨하는 위젯들 업데이트하기
  }

  void createSchedule({
    required ScheduleModel schedule,
  }) async {
    final targetDate = schedule.date;
    final uuid = Uuid();
    final tempId = uuid.v4(); // 유일한 id값을 생성합니다.
    final newSchedule = schedule.copyWIth(id: tempId); // 임시 id를 지정합니다.

    // 긍정적 응답 구간입니다. 서버에서 응답을 받기 전에 캐시를 먼저 업데이트합니다.
    cache.update(
      targetDate,
        (value) => [ // 현존하는 캐시 리스트 끝에 새로운 일정 추가
          ...value,
          newSchedule,
        ]..sort(
          (a, b) => a.startTime.compareTo(
            b.startTime,
          ),
        ),
      // 날짜에 해당되는 값이 없다면 새로운 리스트에 새로운 일정 하나만 추가
      ifAbsent: () => [schedule],
    );

    notifyListeners(); // 캐시 업데이트 반영하기

    try {
      // API 요청을 합니다.
      final savedSchedule = await repository.createSchedule(schedule: schedule);

      cache.update( // 서버 응답 기반으로 캐시 업데이트
        targetDate,
        (value) => value
          .map((e) => e.id == tempId
            ? e.copyWIth(id: savedSchedule,) : e).toList(),
      );
    } catch (e) {
      cache.update( // 삭제 실패시 캐시 롤백하기
        targetDate,
        (value) => value.where((e) => e.id != tempId).toList(),
      );
    }

    notifyListeners();
  }

  void deleteSchedule({
    required DateTime date,
    required String id,
  }) async {
    final targetSchedule = cache[date]!.firstWhere(
      (e) => e.id == id,
    ); // 삭제할 일정 기억

    // 긍정적 응답 (응답 전에 캐시 먼저 업데이트)
    cache.update( // 캐시에서 데이터 삭제
      date,
        (value) => value.where((e) => e.id != id).toList(),
      ifAbsent: () => [],
    );

    notifyListeners(); // 캐시 업데이트 반영하기

    try {
      await repository.deleteSchedule(id: id); // 삭제 함수 실행
    } catch (e) { // 삭제 실패 시 캐시 롤백하기
      cache.update(
        date,
        (value) => [...value, targetSchedule]..sort(
            (a, b) => a.startTime.compareTo(
              b.startTime,
            ),
        ),
      );
    }

    notifyListeners(); // 캐시 업데이트 반영하기
  }


  void changeScheduleDate({
    required DateTime date,
  }) {
    selectedDate = date; // 현재 선택된 날짜를 매개변수로 입력받은 날짜로 변경
    notifyListeners();
  }
}