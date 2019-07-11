const graphql = require('graphql');

const {
  GraphQLObjectType, GraphQLString, GraphQLInt, GraphQLID,
} = graphql;
const mongoose = require('mongoose');

const UserType = require('./types/user_type');
const CategoryType = require('./types/category_type');
const ProductType = require('./types/product_type');

const Category = mongoose.model('categories');
const Product = mongoose.model('products');

const AuthService = require('../services/auth');

const mutation = new GraphQLObjectType({
  name: "Mutation",
  fields: {
    newCategory: {
      type: CategoryType,
      args: {
        name: { type: GraphQLString }
      },
      resolve(_, { name }) {
        return new Category({ name }).save();
      }
    },
    deleteCategory: {
      type: CategoryType,
      args: { _id: { type: GraphQLID } },
      resolve(_, { _id }) {
        return Category.remove({ _id });
      },
    },
    newProduct: {
      type: ProductType,
      args: {
        name: { type: GraphQLString },
        description: { type: GraphQLString },
        weight: { type: GraphQLInt }
      },
      resolve(_, { name, description, weight }) {
        return new Product({ name, description, weight }).save();
      },
    },
    deleteProduct: {
      type: ProductType,
      args: { _id: { type: GraphQLID } },
      resolve(_, { _id }) {
        return Product.remove({ _id });
      },
    },
    updateProductCategory: {
      type: ProductType,
      args: { _id: { type: GraphQLID } },
      resolve(_, { _id }) {
        return Product.remove({ _id });
      },
    },
    register: {
      type: UserType,
      args: {
        name: { type: GraphQLString },
        email: { type: GraphQLString },
        password: { type: GraphQLString }
      },
      resolve(_, args) {
        return AuthService.register(args);
      },
    },
  },
});

module.exports = mutation;
