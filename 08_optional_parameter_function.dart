void greet(String name, {String prefix = 'Hi'}) {
  print('$prefix $name');
}

void greetNew(String name, [String prefix = 'Hello']) {
  print('$prefix $name');
}

void main() {
  greet('Jess');
  greet('Jess', prefix: 'Hello');
  greetNew('Jess');
  greetNew('Jess', 'Hi');
}
