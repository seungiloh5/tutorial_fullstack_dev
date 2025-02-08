require('dotenv').config();
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = require('./src/router');
const bodyParser = require('body-parser');
const http = require('http');
const WebSocket = require('ws');
const chatController = require('./src/chat/controller');
const jwt = require('jsonwebtoken');

// 서버 연결을 위한 Cors 설정
const cors = require('cors');
const { decode } = require('punycode');

// JSON 데이터를 처리하기 위해 body-parser를 설정
app.use(bodyParser.json());

//  URL 인코딩된 데이터를 처리하기 위해 body-parser를 설정
app.use(bodyParser.urlencoded({extended: true}));

// 라우터를 애플리케이션에 등록
app.use('/', router);

app.use(cors());

// HTTP 서버 생성
const server = http.createServer(app);

// WebSocket 서버 생성
const wss = new WebSocket.Server({ server });

// WebSocket 서버 설정을 Controller에 전달
chatController.setWss(wss);

wss.on('connection', (ws, req) => {
    const parsedMessage = JSON.parse(message);
    jwt.verify(parsedMessage.token, process.env.JWT_KEY, (err, decoded) => {
        if (err) {
            ws.close();
        } else {
            chatController.handleMessage(ws, decoded, parsedMessage);
        }
    });
});

// 서버 시작
app.listen(port, () => {
    console.log(`웹서버 구동 중... ${port}`);
});
