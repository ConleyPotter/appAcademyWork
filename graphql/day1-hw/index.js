/* eslint-disable no-else-return */
const mongoose = require('mongoose');
const express = require('express');
const bodyParser = require('body-parser');
const expressGraphQL = require('express-graphql');

const app = express();
const db = require('./config/keys').mongoURI;

const User = require('./models/User');
const Post = require('./models/Post');

const schema = require('./schema/schema');

mongoose
  .connect(db)
  .then(() => console.log('Connected to MongoDB successfully'))
  .catch(err => console.log(err));

app.use(
  '/graphql',
  expressGraphQL({
    schema,
    graphiql: true,
  }),
);

app.use(bodyParser.json());

app.listen(5000, () => console.log('Server is running on port 5000'));
