const path = require('path');
const express = require('express');
const app = express(); // create express app

// add middlewares
app.use(
  express.static(path.join(__dirname), {
    setHeaders: (res, path) => {
      //if the file is an html file, do not cache it
      if (path && path.includes('.html')) {
        res.set('Cache-Control', 'no-cache,no-store,');
      } else {
        res.set('Cache-Control', 'max-age=31536000');
      }
    },
  }),
);

app.use((req, res, next) => {
  res.setHeader('Cache-Control', 'no-cache,no-store,');
  res.sendFile(path.join(__dirname, 'index.html'));
});

// start express server on port 8080
app.listen(process.env.PORT, () => {
  // eslint-disable-next-line no-console
  console.log('server started on port '+ process.env.PORT);
});
