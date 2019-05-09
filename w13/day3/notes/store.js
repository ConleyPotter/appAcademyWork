// INTRODUCTION //

// The store is the central element of Redux's architecture. It holds the 
// global state of an application.

// The store is responsible for:

// - updating an app's state via its reducer;
// - broadcasting the state to an application's view layer via subscription;
// - listening for actions that tell it how and when to change the global state 
//   of an application.

// CREATING THE STORE //

// The redux library provides us with a createStore() method, which takes up 
// to three arguments and returns a Redux store.

createStore(reducer, [preloadedState], [enhancer])

// - reducer (required) - A reducing function that receives the app's current 
//   state and incoming actions, determines how to update the store's state, 
//   and returns the next state (more on this in a moment).
// - preLoadedState (optional) - An object representing any application state 
//   that existed before the store was created.
// - enhancer (optional) - A function that adds extra functionality to the 
//   store.

// Here is an example of how to create a store:

// store.js
import { createStore } from `redux`;
import reducer from './reducer.js';

const store = createStore(reducer);

// STORE API //

// A Redux store is just an object that holds the application state, wrapped in 
// a minimalist API.

// store methods
// - getState() - Returns the store's current state.
// - dispatch(action) - Passes an action into the store's reducer telling it 
//   what information to update.
// - subscribe(callback) - Registers callbacks to be triggered whenever the 
//   store updates. Returns a function, which when invoked, unsubscribes the 
//   callback function from the store.

// UPDATING THE STORE //

// Store updates can only be triggered by dispatching actions:

store.dispatch(action);

// An action in Redux is just a plain object with:

// - a type key indicating the action being performed, and
// - optional payload keys containing any new information.

// For example, if we were building a fruit stand application our store would 
// handle the inventory. We would use the following action to add an orange to 
// the app's state:

// actions.js
const addOrange = {
  type: 'ADD_FRUIT',
  fruit: 'orange'
};

// When store.dispatch() is called, the store passes its current state, along 
// with the action being dispatched, to the reducer. The reducer function takes 
// the two arguments (state and action) and returns the next state. You'll 
// read more on the reducer in the next reading, but for now, think of it as a 
// Redux app's traffic cop, routing new information to its rightful place in 
// the state.

// Let's write a reducer for our fruit stand app:

// reducer.js
const reducer = (state = [], action) => {
  switch (action.type) {
    case 'ADD_FRUIT':
      return [
        ...state,
        action.fruit
      ];
    default:
      return state;
  }
};

export default reducer;

// NB:
// - The reducer's state parameter provides a default value; this is the 
//   initial state of our store prior to any actions. In this case, it's an 
//   empty array.
// - In Redux, the state is immutable, so the reducer must return a new array 
//   or object whenever the state changes.

// Now that we've defined our app's reducing function, we can now dispatch the 
// addOrange action to our store:

// store.js
import { createStore } from 'redux';
import reducer from './reducer.js';
import { addOrange } from './actions.js'

const store = createStore(reducer);

store.getState(); // []
store.dispatch(addOrange);
store.getState(); // ['orange']

// SUBSCRIBING TO THE STORE //

// Once the store has processed a dispatch(), it triggers all its subscribers. 
// Subscribers are callbacks that can be added to the store via subscribe().

// Let's define a callback display and subscribe it to our example's store.

const display = () => {
  console.log(store.getState());
};

const unsubscribeDisplay = store.subscribe(display);
store.dispatch(addOrange); // ['orange', 'orange']

// ...later (when we are done displaying)
// display will no longer be invoked after store.dispatch()
unsubscribeDisplay(); 

// In the example above, the store processed the dispatched action and then 
// called all of its subscribers in response. The only subscriber is our 
// display callback which logs the current state when called.

// REACT COMPONENTS //

// Connecting our React view layer to the store is accomplished via 
// store.subscribe(). Let's define a React component FruitStand that takes the 
// app's store as a prop and subscribes its forceUpdate() method to the store.

// components/fruit_stand.jsx
import React from 'react';

class FruitStand extends React.Component {
  constructor(props) {
    super(props);

		/* Note: Subscribing `forceUpdate()` is not a recommended pattern and used
		for illustration purposes only. See the `NB` below. */
    this.forceUpdate = this.forceUpdate.bind(this);
    this.unsubscribe = this.props.store.subscribe(this.forceUpdate);
  }

  render() {
    return (
      <ul>
        {this.props.store.getState().map((fruit, idx) => (
          <li key={idx}>{fruit}</li>
        ))}
      </ul>
    );
  }

  // let's make sure that when we are done with our component
  // we unsubscribe any callbacks we registered to the store
  componentWillUnmount() {
    this.unsubscribe();
  }
};

export default FruitStand;

// The idea is that by subscribing a React component to the store via its 
// forceUpdate() method, the store triggers re-rendering of the component 
// with the updated state every time it processes a store.dispatch(action) 
// call. In other words, FruitStand will re-render whenever the app state 
// changes.

// NB: Subscribing forceUpdate() tells a component to immediately re-render 
// every time the store's contents change. This pattern works but is a rather 
// blunt instrument for complex components, since re-rendering a parent causes 
// re-rendering of all its children. We'll learn more about the react-redux 
// library soon, which solves this problem via the Provider / connect() API.

