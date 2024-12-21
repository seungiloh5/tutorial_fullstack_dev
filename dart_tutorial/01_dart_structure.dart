// Person 클래스 정의
class Person {
  String name;
  int age;

  // 생성자
  Person(this.name, this.age);

  // ㅇ인사 메시지 출력 메서드
  void greet() {
    print("제 이름은 $name 이고 나이는 $age 입니다.");
  }
}

void main() {
  // Person 클래스의 인스턴스 생성
  var alice = Person("Alice", 30);
  var bob = Person("Bob", 25);

  // greet 메서드 호출
  alice.greet();
  bob.greet();
}
