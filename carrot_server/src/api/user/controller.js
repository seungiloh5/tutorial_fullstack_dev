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

exports.register = (req, res) => {
    res.send('회원 가입');
}   

exports.show = (req, res) => {
    res.send('마이페이지');
}

exports.update = (req, res) => {
    res.send('마이페이지 수정');
}
