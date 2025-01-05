// implicit type conversion ------------------------------------------------------
let result = 3 + '30';
console.log(result); // '330'

// explicit type conversion ------------------------------------------------------
let num = Number('5');
console.log(num); // 5

// equality ------------------------------------------------------
console.log(3 == '3'); // true, 동등 연산자
console.log(3 === '3'); // false, 일치 연산자

// Truthy and Falsy ------------------------------------------------------
if ('') {
    console.log('Truthy');
} else {
    console.log('Falsy');
}