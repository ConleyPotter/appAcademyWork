function mysteryScoping1() {
  var x = 'out of block';
  if (true) {
    var x = 'in block'; 
    console.log(x); // logs 'in block' because var scoped to the funciton
  }
  console.log(x); // logs 'in block' because var was redenied and it's scope
  // survives inside the function
}

function mysteryScoping2() {
  const x = 'out of block';
  if (true) {
    const x = 'in block'; 
    console.log(x); // logs  'in block', because their scope is on the block level 
  }
  console.log(x); // logs 'out of block', same reason
}

function mysteryScoping3() {
  // but const's should not be redined with a variable which would have a larger
  // scope, like var, which has a function level scope
  const x = 'out of block';
  if (true) {
    var x = 'in block'; // raises an area, const's cant be redined with var
    console.log(x);
  }
  console.log(x); // if we took out line 23, this would log 'out of block'
}

function mysteryScoping4() {
  // let is block scoped, so both will log what is expected
  let x = 'out of block'; 
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  console.log(x);
}

function mysteryScoping5() {
  let x = 'out of block';
  if (true) {
    let x = 'in block';
    console.log(x);
  }
  // JS will raise a SyntaxError if you try to declare the same let
  // variable twice in one block
  let x = 'out of block again';
  console.log(x);
}

// // // // // // // // // // // // // // // // // // // // // // // // // // //

function madLib(verb, adjective, noun) {
  console.log(`We shall ${verb} the ${adjective} ${noun}`);
}

// // // // // // // // // // // // // // // // // // // // // // // // // // //

function isSubstring(searchString, subString) {
  return searchString.includes(subString);
}

// // // // // // // // // // // // // // // // // // // // // // // // // // //

function fizzBuzz(array) {
  fizzBuzzes = [];
  array.forEach(el => {
    if ((el % 3 === 2) && (el % 5 === 0)) {
      return;
    } else if (el % 3 === 0) {
      fizzBuzzes.push(el);
    } else if (el % 5 === 0) {
      fizzBuzzes.push(el);
    }
  });
  return fizzBuzzes;
}

console.log(fizzBuzz([1,2,3,15,4,5,15]));
// -> [3,5]

// // // // // // // // // // // // // // // // // // // // // // // // // // //

function isPrime(number) {
  for(let i = 2, s = Math.sqrt(number); i <= s; i++) {
    if (number % i === 0) return false;
  } return number > 1;
}

console.log(isPrime(10));
console.log(isPrime(15485863));

// // // // // // // // // // // // // // // // // // // // // // // // // // //

function sumOfNPrimes(n) {
  primes = [];
  possible_prime = 2;
  while(primes.length < n) {
    if (isPrime(possible_prime)) { primes.push(possible_prime); }
    possible_prime += 1;
  }
  var iterator = primes.values();
  var sum = 0;
  for (let number of iterator) {
    sum += number;
  }
  return sum;
}

console.log(sumOfNPrimes(0));
console.log(sumOfNPrimes(2));
console.log(sumOfNPrimes(4));