class Engine {
  void start() {
    print("엔진이 시작됩니다.");
  }
}

class Car {
  final engine;

  Car(this.engine);

  void start() {
    engine.start();
    print("차가 출발합니다.");
  }
}

void main() {
  final engine = Engine();
  final car = Car(engine);

  car.start();
}
