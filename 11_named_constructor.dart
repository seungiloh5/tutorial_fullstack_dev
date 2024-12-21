class Car {
  String make;
  String bodyType;

  Car.sports(this.make) : bodyType = 'sports';

  void displayInfo() {
    print('Car make: $make, body type: $bodyType');
  }
}

void main() {
  var sportsCar = Car.sports('Ferrari');
  sportsCar.displayInfo();
}
