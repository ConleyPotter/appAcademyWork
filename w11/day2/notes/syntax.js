// SYNTAX //

// semi - colons;
// In Javascript, an expression is a line of code that returns a value.

// A statement is any line of code. Every expression needs a semi - colon at 
// the end. Statements that aren 't expressions don't generally require 
// semi-colons, and may cause syntax errors.

// For example,

// variable assignments are expressions
let x = 5;

// function declarations are statements
function() {}

if (x === 5) { // `if` blocks are statements
  console.log("hello"); // console.log's are expressions
}

// CURLY BRACES //

// Curly braces are used to delineate code blocks such as in function 
// definitions, loops, and if blocks. Curly braces can also be used to define 
// JavaScript objects.

// `if/else` block
if (boolean) {
  // code block...
} else {
  // another code block...
}

// loop
while (condition) {
  // code block...
}

// function definition
function foo() {
  // code block...
}

// JS object
let obj = { key: "value" };

// Missing ucrly braces is a very common mistake! Build good habits early.

if (0 || "" || undefined || null || NaN) {
  console.log('In JavaScript, this will not print.');
}
