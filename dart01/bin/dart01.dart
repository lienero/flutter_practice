import 'package:dart01/dart01.dart' as dart01;

void main() {
  print('Hello world:!');

  // 변수타입 고정 해제
  dynamic name = '코드팩토리';
  name = 1;

  // final로 선언한 변수는 선언 후 값 변경할 수 없음
  final String final_name = '블랙핑크';

  // const로 선언한 변수는 선언 후 값 변경할 수 없음
  const String const_name = 'BTS';
  // 코드를 실행되지 않은 상태에서 값이 확정되면 const 실행될 때 확정되면 final
  final DateTime now = DateTime.now();

  List<String> blackPinkList = ['리사', '지수', '제니', '로제'];

  print(blackPinkList);
  print(blackPinkList[0]);
  print(blackPinkList.length); // 길이반환
  blackPinkList.add('코드팩토리');
  print(blackPinkList);

  // where 은 이터러블 값을 반환
  final newList = blackPinkList.where(
    (name) => name == '리사' || name == '지수', // 리사 또는 지수만 유지
  );

  print(newList);
  // newList를 List로 변환 .toList()
  print(newList.toList());
}
