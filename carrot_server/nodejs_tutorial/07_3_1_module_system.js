// 내장 모듈 사용하기
const fs = require('fs');

fs.readFile('text.text', 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }
    console.log(data);
});

// 외부 모듈 사용하기
const greet = require('./greeting');
greet('World');

// 모듈 내보내기와 불러오기
const add = (a, b) => a + b;
const sub = (a, b) => a - b;

module.exports = {
    add,
    sub
};

const math = require('./math');
console.log(math.add(1, 2));
console.log(math.sub(1, 2));