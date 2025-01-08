const express = require('express');
const router = express.Router(); // Express 라우터 객체 생성

const webController = require('./web/controller');
const apiFeedController = require('./api/feed/controller');
const apiUserController = require('./api/user/controller');

// 웹 컨트롤러를 사용한 라우트 등록
router.get('/', webController.home); // 홈 페이지
router.get('/page/:route', webController.page); // 동적 페이지 처리

// feed API 라우트 등록
router.post('/auth/phone', apiUserController.phone); // API: 휴대폰 인증 번호 발송
router.put('/auth/phone', apiUserController.phoneVerify); // API: 휴대폰 인증 번호 확인
router.post('/auth/register', apiUserController.register); // API: 회원 가입
router.post('/auth/login', apiUserController.login); // API: 로그인
router.post('/api/user/my', apiUserController.update); // API: 내 정보 조회

// user API 라우트 등록
router.get('/api/feed', apiFeedController.index); // API: 피드 목록 조회
router.post('/api/feed', apiFeedController.store); // API: 피드 생성
router.get('/api/feed/:id', apiFeedController.show); // API: 특정 피드 상세 조회
router.put('/api/feed/:id', apiFeedController.update); // API: 특정 피드 수정
router.delete('/api/feed/:id', apiFeedController.delete); // API: 특정 피드 삭제

// 라우터 모듈을 외부로 내보냄
module.exports = router;
