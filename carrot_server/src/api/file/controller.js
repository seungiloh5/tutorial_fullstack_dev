const repository = require('./repository');

exports.upload = async (req, res) => {
    const file = req.file;
    console.log('이미지 업로드');
    console.log(file.origialname);
    console.log(file.path);
    console.log(file.size);

    const {affectedRows, insertId} = await repository.create(
        file.originalname, file.path, file.size);

    if (affectedRows > 0) {
        return res.json({result: 'ok', data: insertId})
    } else {
        return res.json({ result: 'fail'})
    }
}

exports.download = async (req, res) => {
    const { id } = req.params;

    const item = await repository.show(id);

    if (item == null) {
        return res.send({result: 'fail'});
    }

    res.download(item.file_path, item.original_name, (err) => {
        if (err) {
            res.send({ result: "error", message: err.message});
        }
    });
}