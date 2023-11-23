import 'package:dart02/dart02.dart' as dart02;

// class 키워드로 클랫흐 선언
class Idol {
  // 클래스 종속 변수 선언
  String name = '블랙핑크';
  // 클래스 종속 함수(메서드) 선언
  void sayname() {
    // 클래스 내부 속성 지칭 this
    print('저는 ${this.name}입니다');
    // 스코프 안에 같은 속성 이름이 하나만 존재하면 this 생략가능
    print('저는 $name입니다');
  }
}

void main(List<String> arguments) {
  // Idol 인스턴스 생성
  Idol blackPink = Idol();
  blackPink.sayname();
}
