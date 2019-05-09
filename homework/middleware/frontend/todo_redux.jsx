import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

const addLoggingToDispatch = (store) => (next) => (action) => {
  console.log(store.getState());
  console.log(action);
  dispatch(action);
  console.log(store.getState());
  next(action);
}


const applyMiddlewares = (store, ...middleware) => {
  let dispatch = store.dispatch;
  middleware.forEach( (middle) => {
    dispatch = middle(store)(dispatch);
    return Object.assign({}, store, { dispatch });
  });
}

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  let store = configureStore(preloadedState);

  store = applyMiddlewares(store, addLoggingToDispatch);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});