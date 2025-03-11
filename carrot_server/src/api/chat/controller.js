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
                image_id: row.feed_image_id,
                created_at: row.feed_created_at,
            },
            client: {
                id: row.user_id,
                name: row.user_name,
                profile_id: row.user_profile_id,
            },
            lastMessage: row.last_message,
        }));
        res.json({ result : 'ok', data: rooms});
    } catch (error) {
        res.json({ result: 'error', data: error.message });
    }
};

exports.enterRoom = async (req, res) => {
    const { feedId, clientId } = req.body;
    const userId = req.user.id;
    try {
        const roomId = await chatRepository.enterRoom(feedId, clientId, userId);
        res.send({ result: 'ok', roomId });
    } catch (error) {
        console.error(error);
        res.send({ result: 'error', data: error.message });
    }
};

exports.handleMessage = async (ws, user, message) => {
    const { roomId, content } = message;

    try {
        const SavedMessage = await chatRepository.saveMessage(roomId, user.id, content);
        broadcastMessage(roomId, SavedMessage);
    } catch (error) {
        console.error(error);
    }
};

exports.getMissedMessages = async (req, res) => {
    const { page = 1, size = 20} = req.query;
    const { id } = req.params;
    try {
        const messages = await chatRepository.getMessagesAfter(id, page, size);
        res.send({result: 'ok', data: messages});
    } catch (error) {
        console.error(error);
        res.send({result: 'error', data: error.message});
    }
};

const broadcastMessage = (roomId, message) => {
    wss.clients.forEach(function each(client) {
        if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify(message));
        }
    });
};