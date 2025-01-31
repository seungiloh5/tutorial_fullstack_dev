const { pool } = require('../../database');

exports.index  = async (page, size, keyword, userId) => {
    const offset = (page - 1) * size; // page = 2, size = 10 -> offset = 10 -> 11~20번 데이터

    let query = `
    SELECT feed.*, u.name AS user_name, f.id AS image_id,
    (SELECT COUNT(*) FROM favorite WHERE favorite.feed_id = feed.id) AS favorite_count 
    FROM feed 
    LEFT JOIN user u ON u.id = feed.user_id 
    LEFT JOIN files f ON feed.image_id = f.id
    `;

    const whereClause = [];

    if (keyword) {
        const keywordParam = `%${keyword}%`;
        query += `WHERE LOWER(feed.title) LIKE '${keywordParam}' OR LOWER(feed.content) LIKE '${keywordParam}' `;
    }

    if (userId) {
        whereClause.push(`feed.user_id = ${userId} 
        `);
    }

    if (whereClause.length > 0) {
        query += ` WHERE ` + whereClause.join(` AND `);
    }

    query += `ORDER BY feed.id DESC LIMIT ${size} OFFSET ${offset}`;

    try {
        return await pool.query(query, []);
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

exports.show = async (id, userId) => {
    const query = `
    SELECT feed.*, u.name user_name, u.profile_id user_profile, image_id,
    EXISTS (SELECT 1 FROM favorite WHERE favorite.feed_id = feed.id AND favorite.user_id = ${userId}) AS is_favorited
    FROM feed
    LEFT JOIN user u on u.id = feed.user_id
    LEFT JOIN files f1 on feed.image_id = f1.id
    LEFT JOIN files f2 on u.profile_id = f2.id
    WHERE feed.id = ${id}`;

    try {
        let result = await pool.query(query, []);
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