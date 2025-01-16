const mysql = require('mysql2/promise');

// require될 때 createPool 함수는 호출되며, 연결 풀이 생성된거지만 SQL과 연결된거는 아님
exports.pool = mysql.createPool(
    {
        host: process.env.DB_HOST,
        user: process.env.DB_USERNAME,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_DATABASE,
        waitForConnections: true,
        connectionLimit: 10,
        queueLimit: 0
    }
);

// pool.query, pool.execute 함수를 통해 SQL을 실행할 때마다 연결이 생성되고 해제됨
exports.pool.query = async (queryString, params) => {
    const [results] = await this.pool.execute(queryString, params);  
    return results;
};