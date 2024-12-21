void main() {
  // 순서가 있는 컬렉션
  List<String> fruits = [
    'apple',
    'banana',
    'cherry',
  ];

  // 키-값 쌍의 컬렉션
  Map<String, int> fruitCalories = {
    'apple': 95,
    'banana': 105,
    'cherry': 50,
  };

  // 중복을 허용하지 않는 컬렉션
  Set<String> uniqueFruits = Set.from(fruits);

  print(fruits[1]);
  print(fruitCalories['apple']);
  print(uniqueFruits.contains('cherry'));
}
