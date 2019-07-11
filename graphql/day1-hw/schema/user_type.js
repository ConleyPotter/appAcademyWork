const graphql = require('graphql');

const { GraphQLObjectType, GraphQLList } = graphql;
const { GraphQLID, GraphQLString } = graphql;

const mongoose = require("mongoose");

const PostType = require('./post_type');

const User = mongoose.model('user)');

const UserType = new GraphQLObjectType({
  name: 'UserType',
  fields: () => ({
    id: { type: GraphQLID },
    name: { type: GraphQLString },
    email: { type: GraphQLString },
    postsa: {
      type: new GraphQLList(PostType),
      resolve(parentValue) {
        return (
          User.findById(parentValue.id)
            .populate('posts')
            .then(user => user.posts)
        );
      },
    },
  }),
});

module.exports = UserType;
