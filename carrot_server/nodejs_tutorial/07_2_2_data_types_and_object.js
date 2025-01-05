
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