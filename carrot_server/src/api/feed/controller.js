// 피드 목록 조회 핸들러
// GET /feeds 요청에 대해 응답
exports.index = (req, res) => {
    res.send('피드 목록'); // 클라이언트에게 '피드 목록' 문자열을 응답
};

// 피드 생성 핸들러
// POST /feeds 요청에 대해 응답
exports.store = (req, res) => {
    res.send('피드 생성'); // 클라이언트에게 '피드 생성' 문자열을 응답
};

// 특정 피드 상세 조회 핸들러
// GET /feeds/:id 요청에 대해 응답
exports.show = (req, res) => {
    const id = req.params.id; // URL에서 동적 파라미터 "id" 값을 추출
    res.send(`피드 상세: ${id}`); // 클라이언트에게 해당 피드 ID의 상세 정보를 응답
};

// 특정 피드 수정 핸들러
// PUT /feeds/:id 요청에 대해 응답
exports.update = (req, res) => {
    const id = req.params.id; // URL에서 동적 파라미터 "id" 값을 추출
    res.send(`피드 수정: ${id}`); // 클라이언트에게 해당 피드 ID의 수정 결과를 응답
};

// 특정 피드 삭제 핸들러
// DELETE /feeds/:id 요청에 대해 응답
exports.delete = (req, res) => {
    const id = req.params.id; // URL에서 동적 파라미터 "id" 값을 추출
    res.send(`피드 삭제: ${id}`); // 클라이언트에게 해당 피드 ID의 삭제 결과를 응답
};
