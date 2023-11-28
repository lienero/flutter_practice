import 'package:dart07/dart07.dart' as dart07;
// 스트림을 사용하기 위해 패키지 불러오기
import 'dart:async';

// Stream을 반환하는 함수는 async*로 선언합니다.
Stream<String> calculate(int number) async* {
  for (int i = 0; i < 5; i++) {
    // StreamController의 add()처럼 yield 키워드를 이용해서 값 반환
    // yield : return이랑 유사하다. return은 한번 리턴하면 함수가 종료되지만, yield는 종료되지 않는다
    // yield*는 재귀생성함수를 반환할 때 사용합니다.
    yield 'i = $i';
    await Future.delayed(Duration(seconds: 1));
  }
}

void playStream() {
  // StreamController와 마찬가지로 listen() 함수로 콜백 함수 입력
  calculate(1).listen((val) {
    print(val);
  });
}

void main() {
  // StreamController 선언
  // Future은 반환값을 딱 한 번 받아내는 비동기 프로그래밍에서 사용하고,
  // Stream은 지속적으로 값을 반환 받을 때 사용함.
  final controller = StreamController();
  // stream 가져오기
  // ex) final stream = controller.stream;
  // 여러 번 리슨할 수 있는 Broadcast Stream 객체 생성
  final stream = controller.stream.asBroadcastStream();

  // stream에 listen() 함수를 실행하면 값이 주입될 떄마다 콜백 함수를 실행할 수 있습니다.
  // 첫 listen() 함수
  final streamListener1 = stream.listen((val) {
    print('Listening 1');
    print(val);
  });

  final streamListener2 = stream.listen((val) {
    print('Listening 2');
    print(val);
  });

  // Stream에 값을 주입하기
  controller.sink.add(1);
  controller.sink.add(2);
  controller.sink.add(3);
  controller.sink.add(4);

  playStream();
}
