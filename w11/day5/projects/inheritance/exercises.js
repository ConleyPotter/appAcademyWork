// Surrogate Method:

// Function.prototype.inherits = function (anotherObject) {
//   function Surrogate () {}
//   Surrogate.prototype = anotherObject.prototype;
//   this.prototype = new Surrogate();
//   this.prototype.constructor = this;
// }

// function MovingObject (speed) {
//   this.speed = speed;
// }

// function Ship (speed) {
//   MovingObject.call(this, speed);
// }
// Ship.inherits(MovingObject);

// function Asteroid (speed) {
//   MovingObject.call(this, speed);
// }
// Asteroid.inherits(MovingObject);

// const ship = new Ship(90);
// console.log(ship);



// Object.create Method:

Function.prototype.inherits = function (anotherObject) {
  this.prototype = Object.create(anotherObject.prototype);
  this.prototype.constructor = anotherObject;
}

function MovingObject (speed) {
  this.speed = speed;
}

MovingObject.prototype.howFast = function () {
  console.log(`I go ${this.speed} mph!`);
}

function Ship (speed) {
  MovingObject.call(this, speed);
};
Ship.inherits(MovingObject);

Ship.prototype.fly = function () {
  console.log("Vroooom");
};

const ufo = new Ship(90);

ufo.howFast();
ufo.fly();