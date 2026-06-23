const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.json({
    status: "success",
    message: "Hello from Dockerized API!",
    timestamp: new Date(),
    environment: process.env.NODE_ENV || "development",
    author: "Cloud Engineer Intern"
  });
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
