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

// 인스턴스화 할 때 입력받을 타입을 T로 지정
class Cache<T> {
  // data의 타입을 추후 입력될 T 탑이르로 지정합니다.
  final T data;

  Cache({
    required this.data,
  });
}

class Counter {
  // static 키워드를 사용하여 static 변수 선언
  // static 클래스 자체에 귀속
  static int i = 0;

  Counter() {
    i++;
    print(i);
  }
}

void main(List<String> arguments) {
  // cascade operator (..)을 사용하면
  // 선언한 변수의 메서드를 연속으로 실핼할 수 있습니다.
  GirlGroup blackPink = GirlGroup('블랙핑크', 4)
    ..sayName()
    ..sayMembersCount();

  // T타입을 List<int>로 입력
  final cache = Cache<List<int>>(data: [1, 2, 3]);

  // 제네릭에 입력된 값을 통해 data 변수의 타입이 자동으로 유추
  print(cache.data.reduce((value, element) => value + element));

  Counter count1 = Counter();
  Counter count2 = Counter();
}
