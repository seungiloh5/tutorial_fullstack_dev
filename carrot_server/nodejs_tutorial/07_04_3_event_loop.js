// 이벤트 에미터
const EventEmitter = require('events'); 
class MyEmitter extends EventEmitter {}

const myEmitter = new MyEmitter();
myEmitter.on('event', () => {
    console.log('이벤트가 발생했습니다.');
}   );
myEmitter.emit('event');