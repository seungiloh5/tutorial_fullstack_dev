Function createIncrementer(int incrementBy) {
  return (int number) => number + incrementBy;
}

void main() {
  var incrementByTwo = createIncrementer(2);
  print(incrementByTwo(1)); // 3
  print(incrementByTwo(5)); // 7
}

// createIncrementer 함수는 incrementBy를 인자로 받아 익명 함수를 반환합니다.
// 이 익명 함수는 number를 인자로 받아 number + incrementBy를 반환합니다.