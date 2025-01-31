const favoriteRepository = require('./repository');

exports.favoriteToggle = async (req, res) => {
    try {
        const feedId = req.params.id;
        const userId = req.user.id;

        const result = await favoriteRepository.favoriteToggle(userId, feedId);

        res.send({result: 'ok', action: result.result});
    } catch (error) {
        console.error(error);
        res.send({result: 'fail', message: '오류가 발생했습니다.'});
    }
};

exports.getFavoriteFeeds = async (req, res) => {
    try {
        const { page = 1, size = 10} = req.query;
        const userId = req.user.id;
        const favoriteFeeds = await favoriteRepository.getFavoriteFeeds(userId, page, size);
        res.json({result: 'ok', data: favoriteFeeds});
    } catch (error) {
        console.error(error);
        res.status(500).send({result: 'fail', message: '오류가 발생했습니다.'});
    }
};