const { pool } = require('../../database');

exports.index = async (page, size) => {
    const offset = (page - 1) * size;
    const query = `SELECT * FROM community ORDER BY community.id DESC LIMIT ${size} OFFSET ${offset}`;
    return await pool.query(query, [size, offset]);
};

exports.create = async (user, title, content, category, image) => {
    const query = `INSERT INTO community (user_id, title, content, category, image_id) VALUES (?, ?, ?, ?, ?)`;

    const imageId = image === undefined ? null : image;

    return await pool.query(query, [user, title, content, category, imageId]);
};

exports.show = async (id) => {
    const query = `
    SELECT community.*, u.name AS user_name, u.profile_id AS user_profile, image_id
    FROM community
    LEFT JOIN user u ON u.id = community.user_id
    LEFT JOIN files f1 ON community.image_id = f1.id
    LEFT JOIN files f2 ON u.profile_id = f2.id
    WHERE community.id = ${id}`;
    
    let result = await pool.query(query, [id]);
    return (result.length < 0) ? null : result[0];
};

exports.update = async(title, content, category, imageId, id) => {
    const query = `UPDATE community SET title = ${title}, content = ${content}, category = ${category}, image_id = ${imageId}} WHERE id = ${id}`;
    return await pool.query(query, [title, content, category, imageId, id]);
};

exports.delete = async(id) => {
    const query = `DELETE FROM community WHERE id = ${id}`;
    return await pool.query(query, [id]);
};