const { poool } = require('../../database');

// 채팅방의 목록을 가져오는 함수
exports.getRooms = async (userId, page, size) => {
    const offset = (page - 1) * size;

    const query = `
        SELECT room.id,
            feed.id AS feed_id, feed.title AS feed_title, feed.content AS feed_content, 
            feed.price AS feed_price, feed.image_id AS feed_image_id, feed.created_at AS feed_created_at,
            user.id AS user_id, user.name AS user_name, user.profile_id AS user_profile_id,
            latest_chat.created_at AS updated_at, latest_chat.content AS last_message
        FROM room
        LEFT JOIN feed ON room.feed_id = feed.id
        LEFT JOIN user ON user.id = 
            CASE
                WHEN feed.user_id = ? THEN room.user_id
                ELSE feed.user_id
            END
        INNER JOIN (
            SELECT chat1.room_id, chat1.content, chat1,created_at, caht1.user_id
            FROM chat chat1
            INNER JOIN (
                SELECT room_id, MAX(created_at) AS latest
                FROM chat
                GROUP BY rooom_id
            ) chat2 ON chat1.room_id = chat2.room_id AND chat1.created_at = chat2.latest
        ) latest_chat ON room.id = latest_chat.room_id
        WHERE room.user_id = ? OR feed.user_id = ?
        ORDER BY latest_chat.created_at DESC
        LIMIT ? OFFSET ?
        `;

        return await pool.query(query, [userId, userId, userId, size, offset]);
};

// 새로운 채팅방을 생성하는 함수
exports.enterRoom = async (feedId, userId) => {
    const checkQuery = `SELECT * FROM room WHERE feed_id = ? AND user_id = ?`;
    const checkResult = await pool.query(checkQuery, [feedId, userId]);

    if (checkResult.length > 0) {
        return checkResult[0].id;
    } else {
        const insertQuery = `INSERT INTO room (feed_id, user_id) VALUES (?, ?)`;
        const insertResult = await pool.query(insertQuery, [feedId, userId]);
        return insertResult.insertId;
    }
};

// 메시지를 저장하는 함수
exports.saveMessage = async (roomId, userId, content) => {
    const insertQuery = `INSERT INTO chat (room_id, user_id, content) VALUES (?, ?, ?)`;
    const { insertId } = await pool.query(insertQuery, [roomId, userId, content]);

    const selectQuery = `SELECT * FROM chat WHERE id = ?`;
    const rows = await pool.query(selectQuery, [insertId]);
    return (rows.length < 0) ? null : rows[0];
};

// 메시지의 이전 내용을 가져오는 함수
exports.getMessageAfter = async (roomId, page, size) => {
    const offset = (page - 1) * size;
    const query = `SELECT * FROM chat WHERE room_id = ? ORDER BY created_at ASC ESC LIMIT ? OFFSET ?`;
    return pool.query(query, [roomId, size, offset]);
};
