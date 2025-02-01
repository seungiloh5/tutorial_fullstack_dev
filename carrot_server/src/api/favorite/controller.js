const favoriteRepository = require('./repository');

exports.favoriteToggle = async (req, res) => {
    console.log('[Server:FavoriteController] favoriteToggle 실행됨');
    try {
        const feedId = req.params.id;
        const userId = req.user.id;

        const result = await favoriteRepository.favoriteToggle(feedId, userId);

        res.send({result: 'ok', action: result.result});
    } catch (error) {
        console.error(error);
        res.send({result: 'fail', message: '오류가 발생했습니다.'});
    }
};

exports.getFavoriteFeeds = async (req, res) => {
    console.log('[Server:FavoriteController] getFavoriteFeeds 실행됨');
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