const { pool } = require('../../database')

exports.index  = async (page, size, keyword) => {
    const offset = (page - 1) * size; // page = 2, size = 10 -> offset = 10 -> 11~20번 데이터

    let query = `SELECT feed.*, user.name AS user_name, image_id 
    FROM feed 
    LEFT JOIN user 
    ON user.id = feed.user_id 
    LEFT JOIN files 
    ON feed.image_id = files.id`;

    const whereClause = [];
    const params = [];

    if (keyword) {
        query += ` WHERE LOWER(feed.title) LIKE ? OR LOWER(feed.content) LIKE ? `;
        const keywordParam = `%${keyword}%`;
        params.push(keywordParam, keywordParam);
    }


    if (userId) {
        whereClause.push(`feed.userId = ?`);
        params.push(userId);
    }

    if (whereClause.length > 0) {
        query += ` WHERE` + whereClause.join(` AND `);
    }

    query += ` ORDER BY feed.id DESC LIMIT ? OFFSET ?`;
    params.push(size, offset);

    // [임시적] ? 대신 10과 0으로 대체
    query = `SELECT feed.*, user.name AS user_name, image_id 
    FROM feed 
    LEFT JOIN user 
    ON user.id = feed.user_id 
    LEFT JOIN files 
    ON feed.image_id = files.id
    ORDER BY feed.id DESC LIMIT 10 OFFSET 0`;

    try {
        return await pool.query(query, params);
    } catch (err) {
        console.error('[Server] Query error:', err);
        throw err;
    }
}

exports.create = async (user, title, content, price, image) => {
    const query = `INSERT INTO feed (user_id, title, content, price, image_id) VALUES (?, ?, ?, ?, ?)`;

    // image가 없을 경우 null로 처리
    const imageId = image === undefined ? null : image;

    // id가 없을 경우 1(자신)로 처리
    const userId = user.id === undefined ? 1 : user.id;
    
    try {
        return await pool.query(query, [userId, title, content, price, imageId]);
    } catch (err) {
        console.error('[Server] Query error:', err);
        throw err;
    }
}

exports.show = async (id) => {
    const query = `SELECT feed.*, u.name user_name, u.profile_id user_profile, image_id FROM feed
    LEFT JOIN user u on u.id = feed.user_id
    LEFT JOIN files f1 on feed.image_id = f1.id
    LEFT JOIN files f2 on u.profile_id = f2.id
    WHERE feed.id = ?`;

    try {
        let result = await pool.query(query, [id]);
        return (result.length < 0) ? null : result[0];
    } catch (err) {
        console.error('[Server] Query error:', err);
        throw err;
    }
}

exports.update = async (id, title, content, price, image) => {
    const query = `UPDATE feed SET title = ?, content = ?, price = ?, image_id = ? WHERE id = ?`;
    try {
        return await pool.query(query, [title, content, price, image, id]);
    } catch (err) {
        console.error('[Server] Query error:', err);
        throw err;
    }
}

exports.delete = async (id) => {
    const query = `DELETE FROM feed WHERE id = ?`;
    try {
        return await pool.query(query, [id]);
    } catch (err) {
        console.error('[Server] Query error:', err);
        throw err;
    }
}