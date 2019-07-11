// The schema of a GraphQL application is the very heart of configuring GraphQL 
// inside your application. The schema file contains all the knowledge for telling 
// GraphQL exactly what your application data looks like, including what properties 
// your data has, and how those properties relate to each other.

// The graphql/type module is responsible for defining GraphQL types and schema. 
// You can import from either from the graphql/type module, or from the root 
// graphql module itself. Since you've worked with a GraphQL query before, you 
// know that the GraphQL query language is all about selecting fields on objects 
// (like selecting the name field from a User). The most basic components of a 
// GraphQL schema are object types, which represent a kind of object you can fetch 
// from your database, and what fields it has on it. Most of the types in your 
// schema will be object types.

// In the example below we will be creating the schema for an application that 
// just has Users. Users will have an id, a name, and a favoriteNumber. In order to 
// connect GraphQL to our User we first need to inform GraphQL where our user lives, 
// and the the data the User has attached to it. We do this by creating a 
// GraphQLObjectType which tells GraphQL what a User looks like.

// schema.js

const graphql = require("graphql");
// capitalization is important!
const { GraphQLObjectType, GraphQLString, GraphQLInt } = graphql;

// By creating a GraphQLObjectType we are telling GraphQL what a user looks like.
const UserType = new GraphQLObjectType({
  // the name property describes the type we are defining.
  // Since we are defining a UserType the name will be UserType.
  name: "UserType",
  // fields is THE MOST important property - it refers to everything this Type will be able to return to you.
  // Which means all of the data associated with this type in the database.
  // If you don't have a field then you don't have returned data.

  //For our User the fields ar id, name, and favoriteNumber.
  fields: {
    // we have to tell GraphQL what type of data each of these fields
    // returned from the database are.
    id: { type: GraphQLString },
    name: { type: GraphQLString },
    favoriteNumber: { type: GraphQLInt }
  }
});

// ### Root Queries ###

// Awesome we've described what a User looks like - but GraphQL still doesn't know 
// how to enter our database and get to our Users. GraphQL has no entrypoint into 
// our data yet. We can solve this by writing a Root Query. The GraphQL docs 
// describe a Root Query as "a type that represents all of the possible entry 
// points into the GraphQL API". The Root Query is what allows us to jump into 
// the graph of data we are now in the middle of creating.

// Every root query will have a resolve function which will tell GraphQL how to 
// execute that Root Query. Meaning, the resolve function will be where we tell 
// GraphQL how to get data from our database. Like it's name, resolve is meant to 
// resolve a query by telling GraphQL where to find data.

// It'll make more sense when we put it into action:

// we are using lodash for this example because of the nifty find function
const _ = require("lodash");

// since we don't have a database setup yet we'll hardcode
// some data to be fetched here:
const users = [
  { id: "5", name: "Jet", favoriteNumber: 5 },
  { id: "7", name: "Spike", favoriteNumber: 17 }
];

const RootQuery = new GraphQLObjectType({
  // we'll name it exactly that it is
  name: "RootQueryType",
  // the purpose of the root query is to land on a specific node in our graph
  fields: {
    // so we are telling GraphQL if a query is looking for a 'user' we will be returning
    // the UserType we just created
    user: {
      type: UserType,
      // args is short for arguments -> letting GraphQL know that
      // the following arguments will be passed in with this query.
      args: { id: { type: GraphQLString } },
      // the resolve function will take in the parentValue and the arguments being
      // passed the original query. we'll ignore parentValue for now.
      resolve(parentValue, args) {
        // Using Lodash's find to walk through our users to find the first user with the id we
        // passed in.
        return _.find(users, { id: args.id });
      }
    }
  }
});

// Now that we have a Root Query setup you can create a GraphQLSchema. A 
// GraphQLSchema takes in a Root Query and returns a GraphQLSchema instance.

// The implementation for this is pretty simple:

// add our GraphQLSchema to the list of things we are importing
const { GraphQLObjectType, GraphQLString, GraphQLInt, GraphQLSchema } = graphql;

// here we are creating a new Schema instance using the Root Query above.
// we want to make sure we export our Schema.
// Then we can later import it into our `expressGraphQL` middleware
module.exports = new GraphQLSchema({
  query: RootQuery
});

// The final step is to input your exported Schema into your expressGraphQL middleware:

// server/index.js
const express = require("express");
const expressGraphQL = require("express-graphql");
const schema = require("./schema");

const app = express();

// then we just have to register our schema with the expressGraphQL middleware
app.use(
  "/graphql",
  expressGraphQL({
    schema: schema,
    graphiql: true
  })
);

app.listen(5000, () => {
  console.log("Running a GraphQL API server at localhost:5000/graphql");
});

// There you have it! We can test this by heading to localhost:5000/graphql and 
// entering something like the following query:

{
	user(id: "5") {
	  id
    name
    favoriteNumber
	}
}

// We've just covered the basics of how to setup a GraphQL schema and connect 
// it to Express. The general flow you'll follow going forward is that you'll 
// create a Type for each of the tables in your database and then create fields 
// in the rootQuery to be able to access those types. Here is a GraphQL 
// cheatsheet for further reference on schema syntax.