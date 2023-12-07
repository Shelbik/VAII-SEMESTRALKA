const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const {readFileSync} = require("fs");

const app = express();
const port = 3000;

const sqlFilePath ='C://Users//42194//Desktop//vaii semestralka//database//vaiiV2.sql';
const sqlContent = readFileSync(sqlFilePath, 'utf8');


// Подключение к базе данных
const connection = mysql.createConnection({
    host: '127.0.0.1',
    user: 'martiniuc',
    password: 'vm560329',
    database: sqlContent
});

// Парсер для обработки данных из тела запроса
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Обработчик для сохранения данных в базе данных
app.post('/submit', (req, res) => {
    const data = req.body;

    // Вставка данных в таблицу queue
    const insertQueueQuery = `
        INSERT INTO queue (id, owner_email, owner_name, owner_phone, vehicle_number, service_type, in_time, out_time, status_type)
        VALUES (1, 'example@email.com', 'John Doe', '123456789', 'ABC123', 1, TO_TIMESTAMP('2023-12-01 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-01 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

    `;
    connection.query(insertQueueQuery, [data.owner_email, data.owner_name, data.owner_phone, data.vehicle_number, data.service_type], (err, results) => {
        if (err) {
            console.error(err);
            res.status(500).send('Internal Server Error');
            return;
        }

        res.status(200).send('Data inserted successfully');
    });
});

// Запуск сервера
app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
