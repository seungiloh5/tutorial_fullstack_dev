const mysql = require('mmysql2/promise');

// 일반 연결
async function fetchData() {
    const connection = await mysql.createConnection({
        host: 'localhost',
        user: 'root',
        database: 'test'
    });

    try {
        const [results] = await connection.query('SELECT * FROM users');
        console.log(results); 
    } catch (error) {
        console.error(error);
    } finally {
        await connection.end();
    }
}

fetchData();

// Prepared Statement 연결
async function fetchUserData(userId) {
    const connection = await mysql.createConnection({
        host: 'localhost',
        user: 'root',
        database: 'test'
  });
  
  try {
    const [results] = await connection.execute('SELECT * FROM users WHERE id = ?', [userId]);
    console.log(results);
  } catch (error) {
    console.error(error);
  } finally {
    await connection.end();
  }
}

fetchUserData(1);

// Connection Pool 연결 방법
const pool = mysql.createPool({
    host: 'localhost',
    iser: 'root',
    database: 'test',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

async function fetchPoolData() {
    try{
        const [results] = await pool.query('SELECT * FROM users');
        console.log(results);
    } catch (error) {
        console.error(error);
    }
}