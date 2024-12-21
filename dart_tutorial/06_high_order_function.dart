List<dynamic> processNumbers(List<int> numbers, Function(int) processor) {
  return numbers.map(processor).toList();
}

void main() {
  var prices = [10, 20, 30, 40];

  var doubledPriced = processNumbers(prices, (price) => price * 2);
  print(doubledPriced);
}
