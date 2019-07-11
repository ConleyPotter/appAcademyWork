// ### ExpressGraphQL ###

// The simplest way to run an GraphQL API server is to use Express. You will need 
// to install two additional dependencies to your Express application: 
// express-graphql and graphql. The Express middleware express-graphql allows us 
// to quickly and easily setup a GraphQL HTTP server on to an HTTP endpoint 
// (usually called "/graphql"). Once it is configured, express-graphql will allow 
// us to define a GraphQL schema and spin up the GraphiQL interface which we can 
// use to write test queries on our database.

// ### Configuration ###

// As a reminder GraphQL does not replace your backend or sever or any of the 
// essential parts of your application. GraphQL will make up just one small piece 
// of our application.

// Below is a very simple example setting up a server using Express and the 
// express-graphql package:

const express = require('express');
const app = express();
// note the capitalization!
const expressGraphQL = require('express-graphql');

// This adds an additional step to see if the incoming request is intended for the graphql route.
// If it is -  that request is handed off to GraphQL. GraphQL will take care of the request
// before handing the response back to Express.
app.use('/graphql', expressGraphQL({
  // this allows us to use the GraphiQL tool to make queries against our development environment
  graphiql: true,
}));

app.listen(5000, () => {
  console.log('Running a GraphQL API server at localhost:5000/graphql');
});

// This simple setup will return an error: GraphQL middleware options must contain 
// a schema. Right now the only argument we passed in the expressGraphQL middleware 
// was graphiql: true. This error is letting us know that when we setup our 
// expressGraphQL middleware on the '/graphql' route we need to include a schema 
// argument. We'll be covering GraphQL schemas more in depth in a minute - but for 
// now what we need to know is that the schema is how GraphQL knows how to enter 
// your database to get the information it needs.

// So let's fix our error! We'll utilize the buildSchema function for this small 
// example. Though in the future you'll be creating much more complex schemas for 
// your applications using the GraphQLSchema object directly. Here is the setup for 
// creating a schema and connecting it to GraphQL:

const expressGraphQL = require('express-graphql');
const graphql = require('graphql');
// we are requiring graphql here because we need it for the buildSchema function.
const { buildSchema } = graphql;

// The buildSchema function can take in a string and outputs a GraphQLSchema object
const schema = buildSchema(`
  type Query {
    hello: String
  }
`);

// We are only including the root resolver for this demonstration to get a response without having a backend
const root = {
  hello: () => {
    return 'Hello world!';
  },
};


app.use('/graphql', expressGraphQL({
  graphiql: true,
  // register our schema
  schema: schema,
  // here we setup the root to have our response without a backend
  rootValue: root
}));

// Here is what it looks like when we put it all together!

const express = require("express");
const expressGraphQL = require("express-graphql");
const { buildSchema } = require("graphql");

// Construct a schema, using GraphQL schema language
const schema = buildSchema(`
  type Query {
    hello: String
  }
`);

// The root provides a resolver function for each API endpoint
const root = {
  hello: () => {
    return "Hello world!";
  }
};

const app = express();
app.use(
  "/graphql",
  expressGraphQL({
    schema: schema,
    rootValue: root,
    graphiql: true
  })
);

app.listen(5000, () => {
  console.log("Running a GraphQL API server at localhost:5000/graphql");
});

// Now if we start up the server and head to localhost:5000/graphql and query 
// for hello :

{
  hello;
}

// You'll get the response of:

{
  "data": {
    "hello" : "Hello world!"
  }
}

// Meaning that everything worked! We successfully hooked up GraphQL to our 
// Express server. This is a super simple example and we'll be building on this 
// foundation in your homework tonight to build out an bigger application with 
// a database.