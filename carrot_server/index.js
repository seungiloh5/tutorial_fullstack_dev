const express = require('express');
const app = express();
const port = process.env.PORT||3000;

app.get('/', (req, res) => {
    res.send('홈페이지');
}); 

app.get('/page/policy', (req, res) => {
    res.send('이용 약관');
});

app.get('/page/terms', (req, res) => {
    res.send('개인정보 처리방침');
});

app.get('/api/user/my', (req, res) => {
    res.send('내 정보');
});

app.put('/api/user/my', (req, res) => {
    res.send('내 정보 수정');
});

app.get('/api/feed', (req, res) => {
    res.send('피드 목록');
});

app.post('/api/feed', (req, res) => {
    res.send('피드 생성');
});

app.get('/api/feed/:feed', (req, res) => {
    res.send('피드 상세');
});

app.put('/api/feed/:feed', (req, res) => {
    res.send('피드 수정');
});

app.delete('/api/feed/:feed', (req, res) => {
    res.send('피드 삭제');
});

app.listen(port, () => {
    console.log(`웹서버 구동 ... ${port}`);
});