const { exec } = require('child_process');

const runServer = (command) => {
  const server = exec(command);
  server.stdout.on('data', (data) => console.log(data));
  server.stderr.on('data', (data) => console.error(data));
};

runServer('nodemon appServer.js');
runServer('nodemon authServer.js');
