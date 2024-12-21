class Singleton {
  static final Singleton _instance = Singleton._internal();

  // 팩토리 생성자를 사용하여 인스턴스를 반환합니다.
  factory Singleton() {
    return _instance;
  }

  // 생성자를 private로 선언하여 외부에서 인스턴스를 생성하지 못하도록 합니다.
  Singleton._internal();
}

void main() {
  var s1 = Singleton();
  var s2 = Singleton();

  print(identical(s1, s2)); // true
}
