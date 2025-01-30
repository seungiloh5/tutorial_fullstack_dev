const { pool } = require('../../database');

exports.favortieToggle = async (feedId, userId) => {

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