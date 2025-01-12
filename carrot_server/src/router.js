const express = require('express');
const router = express.Router(); // Express 라우터 객체 생성

const multer = require('multer'); // multer 모듈을 불러옴
const upload = multer({dest: 'storage/'}); // 파일 업로드를 위한 multer 설정

const webController = require('./web/controller');
const apiFeedController = require('./api/feed/controller');
const apiUserController = require('./api/user/controller');

//
const {logRequestTime} = require('./middleware/log'); // 미들웨어 불러오기

// 웹 컨트롤러를 사용한 라우트 등록
router.get('/', webController.home); // 홈 페이지
router.get('/page/:route',logRequestTime, webController.page); // 동적 페이지 처리\

// API 컨트롤러를 사용한 라우트 등록
router.use(logRequestTime); // 모든 API 요청에 대해 미들웨어 적용

router.post('/file', upload.single('file'), (req, res) => {
    console.log(req.file);
    res.json(req.file);
});

// feed API 라우트 등록
router.get('/api/user/my', apiUserController.show); // API: 내 정보 조회
router.post('/api/user/my', apiUserController.update); // API: 내 정보 조회
router.post('/api/user/phone/verify', apiUserController.phoneVerify); // API: 인증 번호 확인

// user API 라우트 등록
router.get('/api/feed', apiFeedController.index); // API: 피드 목록 조회
router.post('/api/feed', apiFeedController.store); // API: 피드 생성
router.get('/api/feed/:id', apiFeedController.show); // API: 특정 피드 상세 조회
router.put('/api/feed/:id', apiFeedController.update); // API: 특정 피드 수정
router.delete('/api/feed/:id', apiFeedController.delete); // API: 특정 피드 삭제

// 라우터 모듈을 외부로 내보냄
module.exports = router;
