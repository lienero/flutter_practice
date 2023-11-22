import 'package:dart01/dart01.dart' as dart01;

// 변수의 값을 몇가지 옵션으로 제한하는 기능
enum Status {
  approved,
  pending,
  rejected,
}

int addTwoNumbers(int a, int b) {
  return a + b;
}

// 네임드 파라미터 지정
// required 파라미터는 null 값이 불가능한 타입이면 기본값을 지정해주거나 필수로 입력해야 한다는 뜻
int reqAddTwoNumbers({required int a, required int b}) {
  return a + b;
}

// 기본 값을 갖는 포지셔녈 파라미터
// 네임드 파라미터와 섞어 쓰기 위해서는 반드시 포지셔널 파라미터가 위에 위치해야함
int posAddTwoNumbers(int a, [int b = 2]) {
  return a + b;
}

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

  // List에 있는 값들을 순서대로 순회하면서 값을 변경할 수 있습니다.
  // 화살표를 사용하면 람다 함수
  final newBlackPink = blackPinkList.map((name) => '블랙핑크 $name');
  print(newBlackPink);
  print(newBlackPink.toList());

  // List에 있는 값들을 순서대로 순회하면서 입력된 함수를 실행
  final allMembers =
      blackPinkList.reduce((value, element) => value + ',' + element);

  print(allMembers);

  // reduce() 함수와 실행되는 논리는 똑같지만 reduce()와 달리 어떠한 타입이든 반환가능
  final allMembers2 =
      blackPinkList.fold<int>(0, (value, element) => value + element.length);

  print(allMembers2);

  // 맵 타입은 키와 값의 짝을 저장함
  Map<String, String> dictionary = {
    'Harry Potter': '해리포터',
    'Ron Weasley': '론 위즐리',
    'Hermione Granger': '헤르미온느 그레인저',
  };

  print(dictionary['Harry Potter']);
  print(dictionary['Hermione Granger']);
  print(dictionary.keys);
  print(dictionary.values);

  // 중복없는 값들의 집합
  Set<String> blackPink = {'로제', '지수', '리사', '제니'};

  print(blackPink);
  print(blackPink.contains('로제')); // 값이 있는지 확인
  print(blackPink.toList());

  Status stauts = Status.approved;
  print(stauts);

  // 타입 뒤에 ?를 명시해야만 null값을 가질 수 있음
  double? number = null; // double? number 과 같은 값
  // ?? 기존 값이 null일 때만 저장됩니다.
  number ??= 3;
  print(number);
  number ??= 4; // null이 아님으로 3이 유지
  print(number);

  // 타입 비교 연산자
  print(number is int);
  print(number is! int);

  // 함수 테스트
  // 기본 함수
  print(addTwoNumbers(1, 2));
  // 네임드 파리미터
  print(reqAddTwoNumbers(a: 1, b: 2));
  // 포지셔널 파라미터
  print(posAddTwoNumbers(1));
}
