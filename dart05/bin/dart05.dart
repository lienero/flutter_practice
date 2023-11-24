import 'package:dart05/dart05.dart' as dart05;

// 추상 클래스 지정
abstract class Idol {
  final String name;
  final int membersCount;

  // 생성자
  Idol(this.name, this.membersCount);

  // 추상 메서드 선언
  void sayName();
  void sayMembersCount();
}

// implements 키워드를 사용해 추상 클래스를 구현
class GirlGroup implements Idol {
  final String name;
  final int membersCount;

  GirlGroup(
    this.name,
    this.membersCount,
  );

  void sayName() {
    print('저는 여자 아이돌 ${this.name}입니다');
  }

  void sayMembersCount() {
    print('${this.name} 멤버는 ${this.membersCount}명 입니다.');
  }
}

void main(List<String> arguments) {
  GirlGroup blackPink = GirlGroup('블랙핑크', 4);

  blackPink.sayName();
  blackPink.sayMembersCount();
}
