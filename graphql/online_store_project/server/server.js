/* eslint-disable no-console */
const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const expressGraphQL = require('express-graphql');
const db = require('../config/keys.js').MONGO_URI;

require('../models/index');
const schema = require('./schema/schema');

const app = express();

if (!db) {
  throw new Error('You must provide a string to connect to MongoDB Atlas');
}

mongoose
  .connect(db, { useNewUrlParser: true })
  .then(() => console.log('Connected to MongoDB successfully'))
  .catch(err => console.log(err));

// remember we use bodyParser to parse requests into json
app.use(
  '/graphql',
  expressGraphQL({
    schema,
    graphiql: true,
  }),
);


module.exports = app;
