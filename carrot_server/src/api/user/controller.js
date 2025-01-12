const generateToken = require('./jwt');

exports.register = async (req, res) => {
    // 사용자 정보 검증 로직이 들어갈 위치
    try {
        const UserInfo = {id: 1, name: '홍길동'};
        const token = await generateToken(UserInfo);
        res.json({result: 'ok', access_token: token});
    } catch (error) {
        res.status(500).json({ result: "error", message: "토큰 발급 실패" });
    }
}

exports.phone = (req, res) => {
    res.send('인증 번호 발송');
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
