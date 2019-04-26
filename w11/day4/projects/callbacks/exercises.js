/* eslint-disable no-undef */
// // // // // // // // // // // // // // // // // // // // // // // // // // // 
// CLOCK EXERCISE //

class Clock {
  constructor() {
    const date = new Date();
    this.hours = date.getHours();
    this.minutes = date.getMinutes();
    this.seconds = date.getSeconds();
    setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    this.time = `${this.hours}:${this.minutes}:${this.seconds}`;
    console.log(this.time);
  }

  _tick() {
    if (this.seconds === 60) {
      this.seconds = 0;
    } else {
      this.seconds += 1;
    }
    this.printTime();
  }
}



// const clock = new Clock();

// // // // // // // // // // // // // // // // // // // // // // // // // // // 
// addNumbers EXERCISE //

// const readline = require('readline');

// const reader = readline.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });

// function addNumbers(sum, numsLeft, copmletionCallback) {
//   if (numsLeft > 0) {
//     reader.question(
//       "Please enter a number: ",
//       function (answer) {
//         const int = parseInt(answer);
//         sum += int;
//         console.log(sum);

//         addNumbers(sum, numsLeft - 1, copmletionCallback);
//       }
//       ); 
//     } else {
//       copmletionCallback(sum);
//       reader.close();
//   }
// }

// // addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
// const readline2 = require('readline');

// const reader2 = readline2.createInterface({
//   input: process.stdin,
//   output: process.stdout
// });

// function askIfGreaterThan(el1, el2, callback) {
//   reader2.question(
//     `Is ${el1} greater than ${el2}?`,
//     function (answer) {
//       if (answer === 'yes') {
//         callback(true);
//       } else {
//         callback(false);
//       }
//     }
//   );
// }

// function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
//   if (i == (arr.length - 1)) {
//     outerBubbleSortLoop(madeAnySwaps);
//     // reader2.close();
//   } else if (i < arr.length - 1) {
//     askIfGreaterThan(arr[i], arr[i+1], (isGreaterThan) => {
//       if (isGreaterThan) {
//         let temp = arr[i + 1];
//         arr[i + 1] = arr[i];
//         arr[i] = temp;
//         madeAnySwaps = true;
//       } 
//       innerBubbleSortLoop(arr, (i + 1), madeAnySwaps, outerBubbleSortLoop);
//     });
//   }  
// }

// function absurdBubbleSort(arr, sortCompletionCallback) {
//   function outerBubbleSortLoop(madeAnySwaps) {
//     if (madeAnySwaps) {
//       madeAnySwaps = false;
//       innerBubbleSortLoop(arr, 0, madeAnySwaps, outerBubbleSortLoop);
//       // console.log(arr);
//     } else {
//       sortCompletionCallback(arr);
//     }
//   }

//   outerBubbleSortLoop(true);
// };

// absurdBubbleSort([3, 2, 1], function (arr) {
//   console.log("Sorted array: " + JSON.stringify(arr));
//   reader2.close();
// });

// Function.prototype.myBind = function (context) {
//   const arrow = () => {
//     this.apply(context);
//   };
//   return arrow;
// };

// class Lamp {
//   constructor() {
//     this.name = "a lamp";
//   }
// }

// const turnOn = function () {
//   console.log("Turning on " + this.name);
// };

// const lamp = new Lamp();

// // turnOn(); // should not work the way we want it to

// const boundTurnOn = turnOn.bind(lamp);
// const myBoundTurnOn = turnOn.myBind(lamp);

// boundTurnOn(); // should say "Turning on a lamp"
// myBoundTurnOn(); // should say "Turning on a lamp"

Function.prototype.myThrottle = function (interval) {
  let tooSoon = false;
  return (...args) => {
    if (!tooSoon) {
      tooSoon = true;
      setTimeout( () => {
        tooSoon = false;
      }, interval);
      this(...args);
    }
  };
};




// class Neuron {
//   fire() {
//     console.log("Firing!");
//   }
// };

// const neuron = new Neuron;
// // When we create a new Neuron, 
// // we can call #fire as frequently as we want

// // The following code will try to #fire the neuron every 10ms. Try it in the console:
// const interval = setInterval(() => {
//   neuron.fire();
// }, 10);

// // You can use clearInterval to stop the firing:
// clearInterval(interval);

// Using Function#myThrottle, we should be able to throttle 
// the #fire function of our neuron so that it can only fire 
// once every 500ms:

// neuron.fire = neuron.fire.myThrottle(500);

// const interval = setInterval(() => {
//   neuron.fire();
// }, 10);

// This time, if our Function#myThrottle worked correctly, 
// the Neuron#fire function should only be able to execute 
// every 500ms, even though we're still trying to invoke it 
// every 10ms!

// If we want this behavior for ALL neurons, we can do the same logic in the constructor:

// class Neuron {
//   constructor() {
//     this.fire = this.fire.myThrottle(500);
//   }

//   fire() {
//     console.log("Firing!");
//   }
// };

Function.prototype.myDebounce = fucntion (interval) {
  let timeout;
  return(...args) => {
    const fnCall = () => {
      timeout = null;
      this(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(fnCall, interval);
  };
}