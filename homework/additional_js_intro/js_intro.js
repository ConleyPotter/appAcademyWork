function titlelize (array, callback) {
  titles = array.map(function(el) {
    return `Mx. ${el} Jingleheimer Schmidt`;
  });
  callback(titles);
}

function printCallBack (array) {
  array.forEach(function(el) {
    console.log(el);
  });
}

titlelize(["Mary", "Brian", "Leo"], printCallBack);

function Elephant (name, height, arrayOfTricks) {
  this.name = name;
  this.height = height;
  this.tricks = arrayOfTricks;
}

Elephant.prototype.trumpet = function () {
  console.log(`${this.name} the elephant goes 'phrRRRRRRRRRRR!!!!!!!'`);
};

Elephant.prototype.grow = function () {
  this.height += 12
};

Elephant.prototype.addTrick = function (trick) {
  this.tricks.push(trick);
};

Elephant.prototype.play = function () {
  console.log(`${this.name} is ${this.tricks[Math.floor(Math.random() * this.tricks.length)]}`)
}

const ele1 = new Elephant("Herbert", 123, ["bouncing", "jumping"]);

ele1.trumpet();
ele1.grow();
console.log(ele1.height);
ele1.addTrick("hiding");
ele1.play();

let ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
let charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
let kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
let micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

let herd = [ellie, charlie, kate, micah];

Elephant.prototype.paradeHelper = function () {
  console.log(`${this.name} is trotting by!`);
}

herd.forEach(function (el) {
  el.paradeHelper();
});