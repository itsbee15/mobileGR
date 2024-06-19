const express = require('express');
const sql = require('mssql');
const cors = require('cors');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const app = express();
const port = 3000;

app.use(cors());
app.use(bodyParser.json());

const dbConfig = {
  user: 'developer',
  password: 'developer',
  server: '10.14.90.25',
  database: 'SSC_Dev',
  options: {
    encrypt: false, // Gunakan true jika menggunakan Azure SQL
    trustServerCertificate: true, // Gunakan true jika mengembangkan secara lokal
  },
};

sql.connect(dbConfig, (err) => {
  if (err) {
    console.error('Database connection failed: ', err);
  } else {
    console.log('Database connected');
  }
});

app.post('/login', async (req, res) => {
  const { username, password } = req.body;

  try {
    const result = await sql.query`
      SELECT * FROM text_Employee WHERE Name = ${username} AND NPK = ${password}`;

    if (result.recordset.length > 0) {
      const user = result.recordset[0];
      const token = jwt.sign({ TextFileID: user.TextFileID, name: user.name }, 'your_secret_key', { expiresIn: '3h' });

      res.json({ token, message: 'Login successful' });
    } else {
      res.status(401).json({ message: 'Invalid username or password' });
    }
  } catch (error) {
    console.error('SQL error: ', error);
    res.status(500).send('Internal Server Error');
  }
});

app.get('/delivery-count', async (req, res) => {
  try {
    const result = await sql.query
    `SELECT COALESCE(SUM(Quantity), 0) AS total_quantity
    FROM Text_OSNumber
    WHERE DeliveryDate = CONVERT(date, GETDATE()) 
      AND StatusOS NOT IN ('D', 'C');`;
    res.json(result.recordset[0]);
  } catch (err) {
    console.error('SQL error: ', err);
    res.status(500).send('Internal Server Error');
  }
});

app.get('/goodreceipt', async (req, res) => {
  try {
    const result = await sql.query
    `SELECT COALESCE(SUM(Quantity), 0) AS total_quantity
    FROM Text_GRFromSupplierASKI
    WHERE CreatedDate = CONVERT(date, GETDATE())
    AND StatusGR IN ('Full', 'Partial');`;
    res.json(result.recordset[0]);
  } catch (err) {
    console.error('SQL error: ', err);
    res.status(500).send('Internal Server Error');
  }
});

app.get('/active-delivery', async (req, res) => {
    try {
      const result = await sql.query
      `SELECT 
      s.ShipmentLetterCodeAndCounter AS [No. Surat Jalan],
      s.VendorName AS [Subcon],
      g.OSNumber AS [No. OS],   
      g.DocumentCode [No. QR]
      FROM 
      Text_GRFromSupplierASKI g
      LEFT JOIN 
      OS_ShipmentLetter s ON g.OSNumber = s.OSNumber
      WHERE 
      CONVERT(DATE, g.CreatedDate) = CONVERT(date, GETDATE())
      `;
      res.json(result.recordset);
    } catch (err) {
      console.error('SQL error: ', err);
      res.status(500).send('Internal Server Error');
    }
  });

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
