// Arrow functions are ubiquitous in React and Redux. Here's an example from
// the actions reading on action creators:

const addFruit = (fruit) => ({
  type: 'ADD_FRUIT',
  fruit,
});

// As it stands, addFruit is difficult to debug. Suppose we want to inspect 
// the value of fruit. We can't do this:

const addFruit = (fruit) => ({
  debugger
  type: "ADD_FRUIT",
  fruit
});

// { type: "ADD_FRUIT", fruit } is an object, and we can't put debuggers 
// inside of an object. But we also can't do this:

const addFruit = fruit => (
  debugger
  {
    type: "ADD_FRUIT",
    fruit
  }
);

// As seen in the clearFunction example in the reading on arrow functions, 
// parentheses can be used to implicitly return objects in ES6. Accessing 
// this on GitHub? Use this link. As a result, the above won't work, 
// because we can't put a debugger inside of a return statement.

// Instead, in order to put a debugger inside of addFruit, we first need 
// to convert it into a function with an explicit return statement:

// Now, finally, we can put the debugger before we return:

// If you want to avoid having to do this over and over again as you're 
// debugging your arrow functions, you can make it a habit to write all of 
// your arrow functions with explicit return statements. Do be aware, 
// however, that this is a common convention in Redux and you will see it 
// often out in the wild.

