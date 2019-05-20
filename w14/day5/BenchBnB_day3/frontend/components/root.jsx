import React from 'react';
import { Provider } from 'react-redux';
import { HashRouter } from 'react-router-dom';
import App from './App';

const Root = ({ store }) => (
  <Provider store={store}>
    <HashRouter>
      <App /> 
    </HashRouter>
    {/* the router will go here */}
  </Provider>
)

export default Root;
