/* eslint-disable react/jsx-filename-extension */
import React from 'react';
import { Route } from 'react-router-dom';
import DogIndex from './dogs/DogIndex';
import DogDetail from './dogs/DogDetail'

const App = () => (
  <div>
    <Route exact path="/dogs/:dogId" component={DogDetail} />
    <Route path="/" component={DogIndex} />
  </div>
);

export default App;
