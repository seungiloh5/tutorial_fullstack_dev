// 콜백 함수 기본 개념 ---------------------------------
function fetchData(callback) {
    setTimeout(() => callback('peanut butter'), 1000);
}

fetchData((data) => {
    console.log(data);
});

// 비동기 처리 패턴에서의 콜색 사용 ---------------------------------
const fs = require('fs');

// 파일 읽기 함수 정의
function readFileExample(filePath) {
    // 비동기적으로 파일 읽기
    fs.readFile(filePath, 'utf8', (err, data) => {
        // 에러 처리
        if (err) {
            console.error(err);
            return;
        }
        // 파일 내용 출력
        console.log(data);
});
    // 비동기 작업 중 다른 작업을 처리
    console.log('Reading file...');
}

const filePath = './text.text';
readFileExample(filePath);


// 콜백 지옥과 대응 전략 ---------------------------------
// 콜백 지옥
loginUser(userId, function(user) {
    getUserRole(user, function(roles) {
        checkUserAccess(roles, function(access) {
            // 콜백 지옥 시작
        });
    });
});

// 대응
async function fetchDataAsync() {
    try {
        const user = await loginUser(userId);
        const roles = await getUserRole(user);
        const access = await checkUserAccess(roles);
        // 콜백 지옥 종료
    } catch (err) {
        console.error(err);
    }
}