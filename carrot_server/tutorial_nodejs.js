
// var ----------------------------------------------------------- 
var greeting = 'Hello, world!';
console.log(greeting);

var greeting = 'Hello, again';
console.log(greeting);

// let ----------------------------------------------------------- 
let message = "Hello, world!";
console.log(message);

message = "Hello, again!";
console.log(message);

// let message; // 타입 에러: 이미 선언된 변수입니다.

// const ----------------------------------------------------------- 
const sayHello = "Hello, world!";
console.log(sayHello);

// sayHello = "Hello, again!"; // 타입 에러: 상수의 값을 바꾸려 합니다.

const obj = {message: "Hello"};
obj.message = "Hello, again!";
console.log(obj.message); // 출력됨

// hoisting -----------------------------------------------------------
console.log(hoistedVar); // undefined
var hoistedVar = "I'm a variable!";''

console.log(hoistedNet); // 참조 에러: 초기화 전에 접근했습니다.
let hoistedNet = "I'm a variable";

// template literals -----------------------------------------------------------
const name = "World";
console.log(`Hello, ${name}!`);

const multiLineString = `This is a String
that spans multiple lines
in the code.`;
console.log(multiLineString);

// taged template literals -----------------------------------------------------------
function tag(strings, value1){
    return `${strings[0]}${value1}${strings[1]}`;
}

const var1 = "world";
console.log(tag`Hello, ${var1}!`);

// numbers -----------------------------------------------------------
let integer = 42;
let float = 42.195;
let special = NaN;

// strings -----------------------------------------------------------
let singleQouted = 'Hello, world!';
let doubleQouted = "Hello, world!";
let backtick = `Hello, world!`;

// booleans -----------------------------------------------------------
let isTrue = true;
let isFalse = false;

// arrays -----------------------------------------------------------
let array = [1, 'two', true, 4];
console.log(array[1]);

// objects -----------------------------------------------------------
let object = {
    key1: 'value1',
    key2: 'value2',
    key3: 'value3'
};
console.log(object.key2);

// null, undefined, symbols ------------------------------------------------------
let empty = null;
let notDefined = undefined;
console.log(notDefined);
let sym1 = Symbol('symbol1');
let sym2 = Symbol('symbol2');
console.log(sym1 === sym2); // false