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

void main(List<String> arguments) {
  GirlGroup blackPink = GirlGroup('블랙핑크', 4);

  blackPink.sayName();
  blackPink.sayMembersCount();

  // T타입을 List<int>로 입력
  final cache = Cache<List<int>>(data: [1, 2, 3]);

  // 제네릭에 입력된 값을 통해 data 변수의 타입이 자동으로 유추
  print(cache.data.reduce((value, element) => value + element));
}
