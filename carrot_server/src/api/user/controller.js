const jwt = require('./jwt');
const repository = require('./repository');
const crypto = require('crypto');

exports.register = async (req, res) => {
    const {phone, password, name} = req.body;

    let { count } = await repository.findByPhone(phone);

    if (count > 0) {
        return res.send({result: 'fail', message: '중복된 휴대폰 번호가 존재합니다.'});
    }

    const result = await crypto.pbkdf2Sync(password, process.env.SALT_KEY, 50, 100, 'sha512');

    const { affectedRows, insertId } = await repository.register(phone, result.toString('base64'), name);

    if (affectedRows > 0) {
        const data = await jwt({ id: insertId, name });
        res.send({ result: 'ok', access_token: data });
    } else {
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
        res.send({ result: 'ok', access_token: data});
    }
}

exports.phone = (req, res) => {
    const now = new Date();
    now.setMinutes(now.getMinutes() + 3);

    const expiredTime = now.toISOString().replace('T', ' ').substring(0, 19);

    res.json({result: "ok", expiredTime});
}

exports.phoneVerify = (req, res) => {
    const code = req.body.code;

    if (code === '123456') {
        res.json({result: "ok", message: "성공"});
        return;
    }
    res.json({result: "fail", message: "인증 번호가 맞지 않습니다."});
}

exports.show = (req, res) => {
    res.send('마이페이지');
}

exports.update = (req, res) => {
    res.send('마이페이지 수정');
}
