import 'package:dart07/dart07.dart' as dart07;
// 스트림을 사용하기 위해 패키지 불러오기
import 'dart:async';

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
}
