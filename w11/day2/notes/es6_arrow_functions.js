// normal callback function
function showEach(array) {
  array.forEach(function(el) {
    console.log(el);
  });
}

// Equivalent

// fat arrow function
function showEach(array) {
  array.forEach(el => console.log(el));
}

// // // // // // // // // // // // // // // // // // // // // // // // // // //

// N.B.: In JavaScript, an expression is a line of code that returns a value. 
// Statements are, more generally, any line of code.

// // // // // // // // // // // // // // // // // // // // // // // // // // //

function Cat(name) {
  this.name = name;
  this.toys = ['string', 'ball', 'balloon'];
};

Cat.prototype.play = function meow() {
  this.toys.forEach(function(toy) {
    console.log(`${this.name} plays with ${toy}`);
  });
};

const garfield = new Cat('garfield');
garfield.play();

// play breaks because this in this.name refers to the scope of the forEach 
// method. But if we rewrite play using a fat arrow function, it works:

Cat.prototype.play = function meow() {
  this.toys.forEach(toy => console.log(`${this.name} plays with ${toy}`));
};

garfield.play();

// // // // // // // // // // // // // // // // // // // // // // // // // // //

// IMPLICIT RETURNS //

const halfMyAge = myAge => myAge / 2;
halfMyAge(30) === 15; // true

const halfMyAge = myAge => {
  const age = myAge;
  age / 2;
}

typeof halfMyAge(30) === "undefined"; // true

// To return a value from a fat arrow using a block, you must explicitly return.

const halfMyAge = myAge => {
  const age = myAge;
  return age / 2;
}
halfMyAge(30) === 15; // true

// // // // // // // // // // // // // // // // // // // // // // // // // // //

// To make a single-expression fat arrow return an empty object, wrap it in parentheses:

const clearFunction = () => ({});
typeof clearFunction() === "object"; // true

// // // // // // // // // // // // // // // // // // // // // // // // // // //

// Fat arrows don't scope like normal functions, so you can't reassign this, 
// which is always what it was at the time the fat arrow was declared.

const returnName = () => this.name;
returnName.call({ name: 'Dale Cooper' }) // undefined;

// // // // // // // // // // // // // // // // // // // // // // // // // // //

// Fat arrows can 't be used as constructors.

const FatCat = (name) => this.name = name;

const garfield = new FatCat("garfield"); // TypeError: FatCat is not a constructor

// // // // // // // // // // // // // // // // // // // // // // // // // // //

// Because they don't change scope, fat arrows don't have their own arguments object. 

const hasArgs = function() {
  const noArgs = () => arguments[0];
  return noArgs('FakeArg');
};

hasArgs('RealArg') // returns 'RealArg';

// // // // // // // // // // // // // // // // // // // // // // // // // // //

// ANONYMOUS //

// If you want to name your function you must assign it to a variable like this:
const sayHello = (name) => console.log(`Hi, ${name}!`);
