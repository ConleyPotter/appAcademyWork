/* eslint-disable global-require */
const mongoose = require('mongoose');
const graphql = require('graphql');

const {
  GraphQLObjectType, GraphQLString, GraphQLID, GraphQLInt,
} = graphql;

const ProductType = new GraphQLObjectType({
  name: 'ProductType',
  fields: {
    _id: { type: GraphQLID },
    name: { type: GraphQLString },
    description: { type: GraphQLString },
    weight: { type: GraphQLInt },
    category: { type: require('./category_type') },
  },
});

module.exports = ProductType;
