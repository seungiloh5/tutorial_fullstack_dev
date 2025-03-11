const express = require('express');
const router = express.Router();

const multer = require('multer');
const upload = multer({dest: 'storage/'});

const webController = require('./web/controller');
const apiFeedController = require('./api/feed/controller');
const apiUserController = require('./api/user/controller');
const fileController = require('./api/file/controller');
const chatController = require('./api/chat/controller');
const apiFavoriteController = require('./api/favorite/controller');
const apiCommunityController = require('./api/community/controller');

const {logRequestTime} = require('./middleware/log');
const authenticateToken = require('./middleware/authenticate');

// 사용자 관련 라우트
router.post('/auth/register', apiUserController.register); // API: 내 정보 조회
router.post('/auth/login', apiUserController.login); // API: 내 정보 조회
router.post('/auth/phone', apiUserController.phone); // AP: 만료 시간
router.put('/auth/phone', apiUserController.phoneVerify); // API: 인증 번호 확인

// 마이페이지 라우트, 인증 필요
router.use(authenticateToken); // 인증 미들웨어 적용

// API 컨트롤러를 사용한 라우트 등록
router.use(logRequestTime); // 모든 API 요청에 대해 미들웨어 적용

// 웹 컨트롤러를 사용한 라우트 등록
router.get('/', webController.home); // 홈 페이지
router.get('/page/:route',logRequestTime, webController.page); // 동적 페이지 처리

router.get('/api/user/my', authenticateToken, apiUserController.show); // API: 내 정보 조회
router.put('/api/user/my', authenticateToken,  apiUserController.update); // API: 내 정보 수정

// 파일 업로드
router.post('/file/upload', upload.single('file'), fileController.upload); 
router.get('/file/:id', fileController.download);

// feed API 라우트
router.get('/api/user/my/feed', apiFeedController.myFeed);
router.get('/api/feed', apiFeedController.index); // API: 피드 목록 조회
router.post('/api/feed', apiFeedController.store); // API: 피드 생성
router.get('/api/feed/favorite', apiFavoriteController.getFavoriteFeeds);
router.put('/api/feed/:id/favorite', apiFavoriteController.favoriteToggle);
router.get('/api/feed/:id', apiFeedController.show); // API: 특정 피드 상세 조회
router.put('/api/feed/:id', apiFeedController.update); // API: 특정 피드 수정
router.delete('/api/feed/:id', apiFeedController.delete); // API: 특정 피드 삭제

// community API 라우트
router.get('/api/community', apiCommunityController.index); // API: 커뮤니티 목록 조회
router.post('/api/community', apiCommunityController.store); // API: 커뮤니티 생성
router.get('/api/community/:id', apiCommunityController.show); // API: 특정 커뮤니티 상세 조회
router.put('/api/community/:id', apiCommunityController.update); // API: 특정 커뮤니티 수정
router.delete('/api/community/:id', apiCommunityController.delete); // API: 특정 커뮤니티 삭제

// 채팅 API 라우트
router.get('/api/chat/room/:id', chatController.getMissedMessages);
router.get('/api/chat/room', chatController.roomIndex);
router.post('/api/chat/room', chatController.enterRoom);

// 라우터 모듈을 외부로 내보냄
module.exports = router;
