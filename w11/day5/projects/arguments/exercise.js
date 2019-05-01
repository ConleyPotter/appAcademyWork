function sum (...args) {
  let sum = 0;
  let counter = 0;
  while (counter < args.length) {
    sum += args[counter];
    counter++;
  }
  return sum;
}

console.log(sum(1, 2, 3, 4, 5)); // -> 15
console.log(sum(1,2,3,4,5,6)); // -> 21




// // // // // // // // // // // // // // // // // // // // // // // // // // //
// MY BIND //

// ES5 way:

Function.prototype.myBind = function (ctx) {
  let bindArgs = [].slice.call(arguments, 1);
  var that = this;
  return function () {
    var callArgs = [].slice.call(arguments);
    return that.apply(ctx, bindArgs.concat(callArgs));
  };
};

Array.prototype.slice = function(j = 0) {
  const result = [];
  for (let i = j; i < this.length; i++) {
    result.push(this[i]);
  }
  return result;
};

// ES6+:
Function.prototype.myBind = function (ctx, ...bindArgs) {
  return (...callArgs) => {
    return this.apply(ctx, bindArgs.concat(callArgs));
  };
};

class Cat {
  constructor(name) {
    this.name = name;
  }

  says(sound, person) {
    console.log(`${this.name} says ${sound} to ${person}!`);
    return true;
  }
}

class Dog {
  constructor(name) {
    this.name = name;
  }
}

const markov = new Cat("Markov");
const pavlov = new Dog("Pavlov");

markov.says("meow", "Ned");
// Markov says meow to Ned!
// true

// bind time args are "meow" and "Kush", no call time args
markov.says.myBind(pavlov, "meow", "Kush")();
// Pavlov says meow to Kush!
// true

// no bind time args (other than context), call time args are "meow" and "a tree"
markov.says.myBind(pavlov)("meow", "a tree");
// Pavlov says meow to a tree!
// true

// bind time arg is "meow", call time arg is "Markov"
markov.says.myBind(pavlov, "meow")("Markov");
// Pavlov says meow to Markov!
// true

// no bind time args (other than context), call time args are "meow" and "me"
const notMarkovSays = markov.says.myBind(pavlov);
notMarkovSays("meow", "me");
// Pavlov says meow to me!
// true


function sumThree () {
  return function (num1) {
    return function (num2) {
      return function (num3) {
        return num1 + num2 + num3;
      };
    };
  };
}

const a = sumThree();
const b = a(1);
const c = b(2);
const result = c(3);
console.log(result);
console.log(sumThree()(1)(2)(3));

function curriedSum(numArgs) {
  const nums = [];

  return function _curriedSum(num) {
    nums.push(num);
    if (nums.length === numArgs) {
      // sum and return results
      let result = 0;
      nums.forEach(num => result += num)
      return result;
    } else {
      return _curriedSum;
    }
  };
}

console.log(curriedSum(3)(1)(2)(3));

Function.prototype.curry = function (numArgs) {
  const args = [];
  let that = this;
  
  return function _curryFunction(arg) {
    args.push(arg);
    if (args.length === numArgs) {
      return that;
    } else {
      return _curryFunction;
    }
  };
};