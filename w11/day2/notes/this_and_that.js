// SCOPE ISSUES WITH THIS //

// `times` is the same:
function times(num, fun) {
  for (let i = 0; i < num; i++) {
    fun(); // call is made "function-style"
  }
}

const cat = {
  age: 5,

  ageOneYear: function() {
    this.age += 1;
  }
};

// Function argument is different:
times(10, function() {
  cat.ageOneYear(); // Anonymous closure used so we can acces This
});

// These Two Are Equivalent, different syntax accomplishes same goal

times(10, cat.ageOneYear.bind(cat));




// NESTED THIS PROBLEMS //

function SumCalculator() {
  // scope 0
  this.sum = 0;
}

SumCalculator.prototype.addNumbers = function(numbers) {
  // scope 1
  numbers.forEach(function(number) {
    // scope 2
    this.sum += number; // noooo!
  });

  return this.sum;
};

