const { pool } = require('../../database')

exports.create = async (name, path, size) => {
    const query = `INSERT INTO files
     (original_name, file_path, file_size) VALUES (?, ?, ?)`;
    return await pool.query(query, [name, path, size]);
}