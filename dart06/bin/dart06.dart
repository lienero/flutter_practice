import 'package:dart06/dart06.dart' as dart06;

void main() async {
  // 미래에 받을 값(Future)
  Future<String> name;
  Future<int> number;
  Future<bool> isOpened;
  await addNumbers(1, 1);
  await addNumbers(2, 2);
}

// async 키워드는 함수 매개변수 정의와 바디 사이에 입력합니다.
Future<void> addNumbers(int number1, int number2) async {
  print('$number1 + $number2 계산 시작!');

  // await는 대기하고 싶은 비동기 함수 앞에 입력합니다.
  // Future.delayed()를 사용하면 일정 시간 후에 콜백 함수를 실행할 수 있음
  await Future.delayed(Duration(seconds: 3), () {
    print('$number1 + $number2 = ${number1 + number2}');
  });

  print('$number1 + $number2 코드 실행 끝');
}
