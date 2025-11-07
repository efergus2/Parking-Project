const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
const path = require('path');

const PORT = process.env.PORT || 3000;
const DB_HOST = process.env.DB_HOST || 'localhost';
const DB_USER = process.env.DB_USER || 'parking_user';
const DB_PASSWORD = process.env.DB_PASSWORD || 'parking_pass';
const DB_NAME = process.env.DB_NAME || 'parkingdb';

const app = express();
app.use(cors());
app.use(express.json());

// MySQL pool
const pool = mysql.createPool({
  host: DB_HOST,
  user: DB_USER,
  password: DB_PASSWORD,
  database: DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
});

app.get('/api/lots', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT id, name, capacity, open_spaces, last_updated, note FROM lots');
    const obj = {};
    rows.forEach(r => obj[r.id] = r);
    res.json(obj);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'db_error' });
  }
});

app.get('/api/lot/:id', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT id, name, capacity, open_spaces, last_updated, note FROM lots WHERE id = ?', [req.params.id]);
    if (rows.length === 0) return res.status(404).json({ error: 'not_found' });
    res.json(rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'db_error' });
  }
});

/* Simple POST to set open_spaces (for testing).
   Body: { open_spaces: number }  */
app.post('/api/lot/:id', async (req, res) => {
  const id = req.params.id;
  const open_spaces = Number(req.body.open_spaces);
  if (Number.isNaN(open_spaces) || open_spaces < 0) return res.status(400).json({ error: 'invalid_open_spaces' });
  try {
    const [result] = await pool.query('UPDATE lots SET open_spaces = ?, last_updated = CURRENT_TIMESTAMP WHERE id = ?', [open_spaces, id]);
    if (result.affectedRows === 0) return res.status(404).json({ error: 'not_found' });
    const [rows] = await pool.query('SELECT id, name, capacity, open_spaces, last_updated, note FROM lots WHERE id = ?', [id]);
    res.json(rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'db_error' });
  }
});

// Serve static frontend files
const publicDir = path.join(__dirname, 'public');
app.use(express.static(publicDir));

// fallback to index.html for SPA routing
app.get('*', (req, res) => {
  res.sendFile(path.join(publicDir, 'index.html'));
});

app.listen(PORT, () => console.log(`Backend listening on port ${PORT}`));
