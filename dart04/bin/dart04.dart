import 'package:dart04/dart04.dart' as dart04;

class Idol {
  // _로 변수명을 시작하면 프라이빗 변수
  String _name = '블랙핑크';

  // get 키워드를 사용하면 게터
  // 게터는 메서드와 다르게 매개변수를 전혀 받지 않습니다.
  String get name {
    return this._name;
  }

  // set 키워드로 세터 선언
  // 세터는 매개변수로 딱 하나의 변수를 받을 수 있습니다.
  set name(String name) {
    this._name = name;
  }
}

void main(List<String> arguments) {
  Idol blackPink = Idol();
  // 세터
  blackPink.name = '에이핑크';
  // 게터
  print(blackPink.name);
}
