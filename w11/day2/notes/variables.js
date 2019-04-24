// const (ES6+) //
// const is a new feature in ES6.

// We use const to declare constants.Constants should be used for constructs 
// that will not be re - declared or re - assigned.

// Properties of constants:

  // They are block - scoped like let.
  // Unlike Ruby constants, JavaScript will actually enforce constants by 
  // raising an error if you try to reassign them.
  // Trying to redeclare a constant with an var or let by the same name will 
  // also raise an error.

// A quick example:

// > const favFood = "cheeseboard pizza"; // Initializes a constant
// undefined

// > const favFood = "some inferior food"; // Re-initialization raises an error
// TypeError: Identifier 'favFood' has already been declared

// > let favFood = "some other inferior food"; // Re-initialization raises an error
// TypeError: Identifier 'favFood' has already been declared

// > favFood = "deep-dish pizza"; // Re-assignment raises an error
// TypeError: Assignment to constant variable.