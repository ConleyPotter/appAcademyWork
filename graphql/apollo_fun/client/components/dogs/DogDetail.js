/* eslint-disable react/jsx-filename-extension */
/* eslint-disable react/jsx-indent */
import gql from 'graphql-tag';
import React from 'react';
import { Query } from 'react-apollo';

const FETCH_DOG = gql`
  query FetchDog($id: ID!) {
    dog(_id: $id) {
      _id
      name
      breed
    }
  }
`;

const DogDetail = props => (
    <Query query={FETCH_DOG} variables={props.match.params.dogId}>
      {({ loading, error, data }) => {
        if (loading) return <h1>Loading...</h1>;
        return (
          <div>
            <div>{data.dog.name}</div>
            <div>{data.dog.breed}</div>
          </div>
        );
      }}
    </Query>
);

export default DogDetail;
