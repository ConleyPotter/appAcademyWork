import { createStore } from 'redux';
import reducer from './reducer.js';
import { composeWithDevTools } from 'redux-devtools-extension'

const Store = createStore(reducer, composeWithDevTools);

export default Store;
