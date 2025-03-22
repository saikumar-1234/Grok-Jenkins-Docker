const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from the AWS Cloud Engineer Project!');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});