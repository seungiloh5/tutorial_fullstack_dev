require('dotenv').config();

const express = require('express');
const app = express();

const cors = require('cors');

const port = process.env.PORT || 3000;

const router = require('./src/router');
const bodyParser = require('body-parser');
const http = require('http');
const jwt = require('jsonwebtoken');
const WebSocket = require('ws');
const chatController = require('./src/api/chat/controller');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.use('/', router);
app.use(cors());

const server = http.createServer(app);

const wss = new WebSocket.Server({ server });

chatController.setWss(wss);

wss.on('connection', (ws) => {
    ws.on('message', (message) => {
        const parsedMessage = JSON.parse(message);
        jwt.vertify(parsedMessage.token, process.env.JWT_KEY, (err, decoded) => {
            if (err) {
                ws.close();
            } else {
                chatController.handleMessage(ws, decoded, parsedMessage);
            }
        });
    });
});

server.listen(port, () => {
    console.log(`웹서버 구동 중... ${port}`);
});
