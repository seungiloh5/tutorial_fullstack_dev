const jwt = require('./jwt');
const repository = require('./repository');
const crypto = require('crypto');

exports.register = async (req, res) => {
    const {phone, password, name} = req.body;

    let { count } = await repository.findByPhone(phone);

    if (count > 0) {
        console.log("[Server] 중복된 휴대폰 번호가 존재합니다.");
        return res.send({result: 'fail', message: '중복된 휴대폰 번호가 존재합니다.'});
    }

    const result = await crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512');
    console.log("[Server] 암호화된 비밀번호: ", result.toString('base64'));

    const { affectedRows, insertId } = await repository.register(phone, result.toString('base64'), name);
    console.log("[Server] insertId: ", insertId);
    console.log("[Server] affectedRows: ", affectedRows);

    if (affectedRows > 0) {
        console.log("[Server] 회원가입 성공");
        const data = await jwt({ id: insertId, name });
        res.send({ result: 'ok', access_token: data });
    } else {
        console.log("[Server] 회원가입 실패");
        res.send({ result: 'fail', message: '알 수 없는 오류' });
    }
}

exports.login = async (req, res) => {
    const { phone, password } = req.body;

    const result = await crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512');

    const item = await repository.login(phone, result.toString('base64'));

    if (item == null) {
        return res.send({ result: 'fail', message: '휴대폰 번호 혹은 비밀번호를 확인해 주세요!' });
    } else {
        const data = await jwt({ id: item.id, name: item.name });
        console.log("[Server] 로그인 성공");
        res.send({ result: 'ok', access_token: data});
    }
}

exports.phone = async (req, res) => {
    const { phone } = req.body;

    // 핸드폰 번호가 없을 경우
    if (!phone) {
        return res.status(400).json({ result: "error", message: "핸드폰 번호가 필요합니다." });
    } 

    // 랜덤 네자리 인증번호 생성
    const verificationCode = '1234'
    console.log("[Server] 인증번호: ", verificationCode);

    // 만료 시간 계산
    const now = new Date();
    // now.setMinutes(now.getMinutes() + 3); // 분을 더함
    now.setSeconds(now.getSeconds() + 30); // 초를 더함
    const expiredTime = now.toISOString().replace('T', ' ').substring(0, 19);
    console.log("[Server] 만료시간: ", expiredTime);

    res.json({result: "ok", phone, verificationCode, expiredTime});
}

exports.phoneVerify = async (req, res) => {
    const code = req.body.code;

    if (code === '1234') {
        console.log("[Server] 인증 성공");
        res.json({result: "ok", message: "성공"});
        return;
    }
    res.json({result: "fail", message: "인증 번호가 맞지 않습니다."});
}

exports.show = async (req, res) => {

    const user = req.user;

    const item = await repository.findId(user.id);

    if (item == null) {
        return res.send({ result: 'fail', message: '회원을 찾을 수 없습니다.'});
    } else {
        console.log("[Server] 내 정보 조회 성공");
        res.send({ result: 'ok', data: item});
    }
}

exports.update = async (req, res) => {
    const { name, profile_id } = req.body;
    const user = req.user;

    const result = await repository.update(user.id, name, profile_id);

    if(result.affectedRows > 0) {
        const item = await repository.findId(user.id);
        console.log("[Server] 내 정보 수정 성공");
        res.send({ result: 'ok', data: item});
    } else {
        res.send({ result: 'fail', message: '오류가 발생하였습니다.' });
    }
}
