const WebSocket = require('ws');
const chatRepository = require('./repository');

let wss;

exports.setWss = (webSocketServer) => {
    wss = webSocketServer;
};

exports.roomIndex = async (req, res) => {
    const { page = 1, size = 20 } = req.query;
    const userId = req.user.id;

    try {
        const roomsData = await chatRepository.getRooms(userId, page, size);
        const rooms = roomsData.map(row => ({
            id: row.id,
            updatedAt: row.updated_at,
            feed: {
                id: row.feed_id,
                title: row.feed_title,
                content: row.feed_content,
                price: row.feed_price,
                image_id: row.feed_image_id,
                created_at: row.feed_created_at,
            },
            client: {
                id: row.user_id,
                name: row.user_name,
                profile: row.user_profile_id,
            },
            lastMessage: row.last_message,
        }));
        res.json({ result: 'ok', data: rooms });
    } catch (error) {
        res.json({ result: 'fail', message: error.message });
    }
};

exports.enterRoom = async (req, res) => {
    const { feedId, clientId } = req.body;
    const userId = req.user.id;
    try {
        const roomId = await chatRepository.enterRoom(feedId, userId, clientId);
        res.json({ result: 'ok', data: roomId });
    } catch (error) {
        res.json({ result: 'fail', message: error.message });
    }
};

exports.handleMessage = async (ws, user, message) => {
    const { roomId, content } = message;

    try {
        const savedMessage = await chatRepository.saveMessage(roomId, user.id, content);
        broadcastMessage(roomId, savedMessage);
    } catch (error) {
        console.error('Error handling message:', error);
    }
};

exports.getMissedMessages = async (req, res) => {
    const { page = 1, size = 20 } = req.query;
    const { id } = req.params;
    try {
        const messages = await chatRepository.getMissedMessages(id, page, size);
        res.json({ result: 'ok', data: messages });
    } catch (error) {
        res.json({ result: 'error', message: error.message });
    }
};

const broadcastMessage = (roomId, message) => {
    wss.clients.forEach(function each(client) {
        if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify(message));
        }
    });
};