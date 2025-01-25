require('dotenv').config();

// Express 모듈을 불러옴
const express = require('express');

// Express 애플리케이션 생성
const app = express();

// 서버 연결을 위한 Cors 설정
const cors = require('cors');

// 서버 포트를 설정
// 환경 변수에 PORT 값이 설정되어 있으면 그 값을 사용하고, 그렇지 않으면 기본값으로 3000을 사용
const port = process.env.PORT || 3000;

// 외부 라우터 모듈을 불러옴
// ./src/router 파일에 정의된 라우터를 사용
const router = require('./src/router');

// body-parser 모듈을 불러옴
const bodyParser = require('body-parser');

// JSON 데이터를 처리하기 위해 body-parser를 설정
app.use(bodyParser.json());

//  URL 인코딩된 데이터를 처리하기 위해 body-parser를 설정
app.use(bodyParser.urlencoded({extended: true}));

// 라우터를 애플리케이션에 등록
// 모든 경로에 대해 router를 사용하도록 설정
app.use('/', router);

app.use(cors());

// 서버 시작
// 지정된 포트에서 서버를 시작하고, 성공적으로 시작되면 콘솔에 메시지를 출력
app.listen(port, () => {
    console.log(`웹서버 구동 중... ${port}`);
});
