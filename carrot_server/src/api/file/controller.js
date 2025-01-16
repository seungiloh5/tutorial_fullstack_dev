const repository = require('./repository');

exports.upload = async (req, res) => {
    const file = req.file;

    const {affectedRows, insertId} = await repository.create(
        file.originalname, file.path, file.size);

    if (affectedRows > 0) {
        return res.json({result: 'ok', data: insertId})
    }
    return res.josn({ result: 'fail'})
}
