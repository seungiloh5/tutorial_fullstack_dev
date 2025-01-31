const { pool } = require('../../database');

exports.favoriteToggle = async (feedId, userId) => {

    const checkQuery = `SELECT * FROM favorite WHERE feed_id = ${feedId} AND user_id = ${userId}`;
    const checkResult = await pool.query(checkQuery, [feedId, userId]);

    if (checkResult.length > 0) {
        const deleteQuery = `DELETE FROM favorite WHERE feed_id = ${feedId} AND user_id = ${userId}`;
        await pool.query(deleteQuery, [feedId, userId]);
        return {result: 'removed'};
    } else {
        const insertQuery = `INSERT INTO favorite (feed_id, user_id) VALUES (?, ?)`;
        await pool.query(insertQuery, [feedId, userId]);
        return {result: 'added'};
    }
};

exports.getFavoriteFeeds = async (userId, page, size) => {
    const offset = (page - 1) * size;

    const query = `
        SELECT feed.*, u.name AS user_name, f.id AS iamge_id,
        (SELECT COUNT(*) FROM favorite WHERE favorite.feed_id = feed.id) AS favorite_count
        FROM favorite
        JOIN feed ON favorite.feed_id = feed.id
        LEFT JOIN user u ON u.id = feed.user_id
        LEFT JOIN files f ON feed.image_id = f.id
        WHERE favorite.user_id = ${userId}
        ORDER BY favorite.created_at DESC
        LIMIT ${size} OFFSET ${offset}
        `;
    
        return await pool.query(query, [userId, size, offset]);
};