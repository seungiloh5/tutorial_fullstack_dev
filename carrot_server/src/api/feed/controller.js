const repository = require('./repository');

exports.index = async (req, res) => {
    const { page = 1, size = 10, keyword = ''} = req.query;
    const userId = req.user.id; // 현재 고르인한 사용자의 ID

    const trimmedKeyword = keyword.trim().toLowerCase(); // 검색어를 소문자로 변환하고 양쪽 공백을 제거

    const items = await repository.index(page, size, trimmedKeyword); // 피드 목록 조회

    const modifiedItems = items.map(item => ({
        ...item,
        is_me: (user_Id == item.user_id)
    }));

    res.json({result: 'ok', data: modifiedItems});
}


// 피드 생성 핸들러
// POST /feeds 요청에 대해 응답
exports.store = async (req, res) => {
    const body = req.body; // 클라이언트가 전달한 JSON 데이터를 추출
    const user = req.user;

    const result = await repository.create(user.id, body.title, body.content, body.price, body.imageId);

    if (result.affectedRows > 0) {
        res.json({result: 'ok', data: result.inserId});
    } else {
        res.send({result: 'fail', message: '오류가 발생하였습니다.'});
    }
};

// 특정 피드 상세 조회 핸들러
// GET /feeds/:id 요청에 대해 응답
exports.show = async(req, res) => {
    const id = req.params.id;
    const user = req.user;

    const item = await respository.show(id);

    const modifiedItems = {
        ...item,
        writer: {
            id: item.user_id,
            name: item.user_name,
            profile_id: item.user_profile
        }
    }

    delete modifiedItems.user_id;
    delete modifiedItems.user_name;
    delete modifiedItems.user_profile;

    modifiedItems['is_me'] = (user.id == item.user_id);

    res.send({result: 'ok', data: modifiedItems});
};

// 특정 피드 수정 핸들러
// PUT /feeds/:id 요청에 대해 응답
exports.update = async(req, res) => {
    const id = req.params.id;
    const body = req.body;
    const user = req.user;

    const item = await repository.show(id);

    if (user.id !== item.user_id) {
        res.send({result: 'fail', message: '타인의 글을 수정할 수 없습니다.'});
        return;
    }

    const result = await repository.update(body.title, body.content, body.price, body.imageId);

    if (result.affectedRows > 0) {
        res.send({result: 'ok', data: body});
    } else {
        res.send({result: 'fail', message: '오류가 발생하였습니다.'});
    }
};

// 특정 피드 삭제 핸들러
// DELETE /feeds/:id 요청에 대해 응답
exports.delete = async(req, res) => {
    const id = req.params.id;
    const user = req.user;

    const item = await repository.show(id);

    if(user.id !== item.user_id) {
        res.send({result: 'fail', message: '타인의 글을 삭제할 수 없습니다.'});
        return;
    } else {
        await repository.delete(id);
        res.send({result: 'ok', data: id});
    }
};
