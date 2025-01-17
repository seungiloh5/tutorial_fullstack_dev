const jwt = require('jsonwebtoken');

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization'];

    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.State(401).send({ message: '토근이 없습니다.'});
    }

    jwt.verify(token, process.env.JWT_KEY, (err, decoded) => {
        if (err) {
            return res.status(403).send({ message: '유효하지 않은 토근입니다.'});
        }
        req.user = decoded;
        next(); // 요청 처리 흐름을 다음 미들웨어 또는 컨트롤러로 넘김
    });
}