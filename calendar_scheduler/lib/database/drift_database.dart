import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

// private 값까지 불러올 수 있음
part 'drift_database.g.dart'; // part 파일 지정

@DriftDatabase( // 사용할 테이블 등록
  tables: [
    Schedules,
  ], 
)

// Code Generation으로 생성할 클래스 상속
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());
  Stream<List<Schedule>> watchScedules(DateTime date) =>
      // 데이터를 조회하고 변화 감지
      // watch() 함수는 변화가 있을 때마다 자동으로 데이터를 불러옴
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

  // 새로운 일정을 생성하는 기능
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  // 일정을 삭제하는 기능
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  // 테이블의 변화가 있을 때 마다 1씩 올려줘서 테이블 구조가 변경된다는 걸 인지
  @override
  int get schemaVersion => 1;
}

// LazyDatabase 부모 : 드리프트 데이터베잇흐 객체에 필수
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // 데이터베이스 파일 저장할 폴더
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}