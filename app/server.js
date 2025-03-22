const express = require('express');  // Imports the Express framework
const app = express();  // Creates an Express application instance

app.get('/', (req, res) => {  // Defines a route handler for GET requests to the root URL (/)
  res.send('Hello from the AWS Cloud Engineer Project!');  // Sends a response to the client
});

app.listen(3000, () => {  // Starts the server on port 3000
  console.log('Server running on port 3000');  // Logs a message to the console when the server starts
});