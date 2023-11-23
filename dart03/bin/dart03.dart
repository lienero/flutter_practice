import 'package:dart03/dart03.dart' as dart03;

class Idol {
  final String name;
  final int membersCount;

  // 생성자
  Idol(String name, int membersCount)
      // 1개 이상의 변수를 저장하고 싶을 때는 , 기호로 연결해주면 됩니다.
      : this.name = name,
        this.membersCount = membersCount;
  // 네임드 생성자
  // {클래스명.네임드 생성자명} 형식
  Idol.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.membersCount = map['membersCount'];

  void sayName() {
    print('저는 ${this.name}입니다. ${this.name} 멤버는 ${this.membersCount}명입니다.');
  }

  void sayMembersCount() {
    print('${this.name} 멤버는 ${this.membersCount}명 입니다.');
  }
}

// extends 키워드를 사용하여 상속
class BoyGroup extends Idol {
  // 상속받은 생성자
  BoyGroup(
    String name,
    int membersCount,
  ) : super(
          // super는 부모클래스를 지칭합니다
          name, membersCount,
        );
  // 상속받지 않은 기능
  void sayMale() {
    print('저는 남자 아이돌입니다.');
  }
}

class GirlGroup extends Idol {
  GirlGroup(
    // 직접 super 키워드 사용
    super.name,
    super.membersCount,
  );
  // override 키워드를 사용해 오버라이드
  @override
  void sayName() {
    print('저는 여자 아이돌 ${this.name}입니다');
  }
}

// implements 키워드를 사용하면 인터페이스로 사용 가능
// 인터페이스는 반드시 모든 기능을 다시 정의해줘야함
class GirlGroup2 implements Idol {
  final String name;
  final int membersCount;
  GirlGroup2(
    // 직접 super 키워드 사용
    this.name,
    this.membersCount,
  );
  // override 키워드를 사용해 오버라이드
  void sayName() {
    print('저는 여자 아이돌 ${this.name}입니다');
  }

  void sayMembersCount() {
    print('${this.name} 멤버는 ${this.membersCount}명 입니다.');
  }
}

void main() {
  Idol blackPink = Idol('블랙핑크', 4);
  blackPink.sayName();
  // fromMap이라는 네임드 생성자 사용
  Idol bts = Idol.fromMap({
    'name': 'BTS',
    'membersCount': 7,
  });
  bts.sayName();

  // 생성자로 객체 생성
  BoyGroup bts2 = BoyGroup('BTS', 7);
  bts2.sayName();
  bts2.sayMembersCount();
  bts2.sayMale();

  GirlGroup blackPink2 = GirlGroup('블랙핑크', 4);
  // 오버라이드 된 메소드 사용
  blackPink2.sayName();

  GirlGroup2 blackPink3 = GirlGroup2('블랙핑크', 4);
  blackPink3.sayName();
  blackPink3.sayMembersCount();
}
