void main() {
  // 정수 리스틀를 정의합니다.
  List<int> numbers = [1, 2, 3, 4, 5];

  // 각 요소를 두 배로 만듭니다.
  var doubledNumbers = numbers.map((n) => n * 2).toList();

  // 짝수만 필터링합니다.
  var evenNumbers = numbers.where((n) => n % 2 == 0).toList();

  // 모든 요소의 합을 계산합니다.
  int sum = numbers.reduce((cur, n) => cur + n);

  print(doubledNumbers);
  print(evenNumbers);
  print(sum);
}

// (n) => n * 2 는 익명 함수입니다.
// 즉 축약적 표현으로 (int n) { return n * 2; } 와 동일합니다.
// 이 함수는 n을 인자로 받아 n * 2를 반환합니다.
// map 메서드는 리스트의 각 요소에 함수를 적용하고 그 결과를 새로운 리스트로 반환합니다.
// where 메서드는 리스트의 각 요소에 함수를 적용하고 그 결과가 참인 요소만을 포함하는 새로운 리스트를 반환합니다.
// reduce 메서드는 리스트의 각 요소에 함수를 적용하고 그 결과를 누적하여 반환합니다.