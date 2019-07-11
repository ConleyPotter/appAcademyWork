// When people talk about GraphQL they usually talk about how data is fetched 
// in queries. However, any complete data platform needs a way to modify 
// server-side data as well. GraphQL can modify our database through the use 
// of mutations. You've already had some experience using mutations to update 
// data so in this reading we'll be covering the basics of how to write your 
// own mutations.

// Let's assume we already have our User type, Root Type and schema already 
// set up:

//schema/user_type.js
const graphql = require("graphql");
const { GraphQLObjectType, GraphQLString, GraphQLInt } = graphql;

const UserType = new GraphQLObjectType({
  name: "User",
  fields: {
    id: { type: GraphQLString },
    name: { type: GraphQLString }
  }
});

// Now we can query for a user but don't yet have a way to add one through 
// GraphQL. Writing a mutation is very similar to writing a root query type. 
// We define the arguments to be passed into the mutation, then write a resolve 
// function to access the required information from the server:

// schema/mutations.js
const graphql = require("graphql");
const { GraphQLObjectType, GraphQLString } = graphql;

const UserType = require("./user_type");
const User = mongoose.model("user");

// our mutations are still configured in the fields of a GraphQLObjectType
const mutation = new GraphQLObjectType({
  // set the name to be indicative that this GraphQLObject will contain mutations
  name: "Mutation",
  fields: {
    // newUser will be the name of this mutation
    newUser: {
      // this mutation will create a new user so it will be of the User type
      type: UserType,
      args: {
        // since we *need* the name argument to make a new user
        // we'll make this argument GraphQLNonNull
        name: { type: new GraphQLNonNull(GraphQLString) }
      },
      // the resolve function will tell GraphQL how to run this mutation
      // in this case telling GraphQL to save this new User to our database
      resolve(parentValue, { name }) {
        // this would just be the mongoose model `save` function
        return new User({ name }).save();
      }
    }
  }
});

// Although our resolve functions may become more complex for further mutations, 
// the basic syntax will remain the same.

// Any mutations you write will need to be added to your GraphQLSchema instance 
// when it is created. Which is actually pretty simple - all we have to do is 
// add our mutations to your schema like so:

// schema/schema.js
const graphql = require("graphql");
const { GraphQLSchema } = graphql;

const RootQueryType = require("./root_query_type");
const mutations = require("./mutations");

// add our mutations to the Schema
module.exports = new GraphQLSchema({
  query: RootQueryType,
  mutation: mutations
});

// Then to run our mutation we could go to GraphiQL and run the following:

// we have to tell GraphQL we are running a mutation
mutation {
  // the name of the mutation we just created
  newUser(name:"name") {
    id,
    name
  }
}

// That's it! You create your mutations in a GraphQLObjectType, with a name and 
// fields, each field being a mutation. Each mutation will need the type of 
// data they are mutating (the User type in this case), the arguments for what 
// is being changed in the database, and the resolve function that will tell 
// GraphQL how to execute the mutation.

// There's one more important distinction between queries and mutations: While 
// query fields are executed in parallel, mutation fields run in a series, one 
// after the other.

// This means that if we send two addUser mutations in one request, the first 
// is guaranteed to finish before the second begins. For more on mutations check 
//  out the GraphQL docs.