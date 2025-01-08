// 홈 페이지 라우트 핸들러
// "/home" 경로와 같은 요청에 대해 응답
exports.home = (req, res) => {
    res.send('애플리케이션 소개'); // 클라이언트에게 "애플리케이션 소개" 문자열을 응답
};

// 동적 페이지 라우트 핸들러
// "/page/:route" 경로와 같은 요청에 대해 처리
exports.page = (req, res) => {
    const route = req.params.route; // 동적 URL 파라미터 "route" 값을 추출

    // route 값이 "policy"인 경우
    if (route == 'policy') {
        res.send('개인정보 처리방침'); // 클라이언트에게 "개인정보 처리방침" 문자열을 응답
    }

    // route 값이 "terms"인 경우
    if (route == 'terms') {
        res.send('이용 약관'); // 클라이언트에게 "이용 약관" 문자열을 응답
    }
};
