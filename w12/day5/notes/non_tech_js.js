/* eslint-disable require-jsdoc */
// JavaScript is a critical tool for any web developer, as it is one of the
// three primary languages that ships with the browser. Whereas HTML and CSS
// respectively provide static content and its styling, JavaScript makes
// websites dynamic. With JavaScript, the initial content of a webpage can
// be selected, altered, and transformed on a conditional basis.

// JavaScript is now no longer used just on the client-side, but on the
// server-side as well. There are various Node.js frameworks designed for
// this purpose.

// HISTORY //

// JavaScript was introduced during the initial browser wars. In 1995,
// Netscape Communications recruited Brendan Eich to add a language to
// their browser, Netscape Navigator, that non-professional programmers could
// use with ease. Having decided to incorporate Java into their browser with
// the collaboration of Sun Microsystems, Netscape Communications decided to
// have Eich's new language act as a complement to Java. Eich completed his
// tasked language in ten days, and it eventually became known as JavaScript.

// Following suit, Microsoft released a similar dialect called JScript in
// Internet Explorer 3.0.In June 1997, ECMAScript was established as a
// scripting - language specification - a standard - and various languages
// are implementations of that standard. Both JavaScript and JScript aim to
// fulfill the ECMA standards, but both also offer functionality that goes
// beyond the mutual specification.

// ALTERNATIVES TO JAVASCRIPT //

// JavaScript, JScript, and ActionScript are all valid implementations of ECMAScript.

// - While it does maintain slight differences with JavaScript, JScript is
//   essentially the same language with a different name to avoid trademark
//   issues. However, the difference is so slight that anything written in
//   JavaScript is presumed to run properly in a browser that is built on
//   JScript. Microsoft's Internet Explorer is the only browser that uses
//   JScript.
// - ActionScript is much more of an object-oriented language than JavaScript.
//   For instance, it makes use of class inheritance, as opposed to JavaScript's
//   prototypal inheritance. ActionScript was originally developed by Macromedia
//   Inc., which merged into Adobe Systems. It is now associated with
//   development in both Adobe AIR and Adobe Flash, so its use has rapidly
//   declined since   the Apple and Adobe Flash controversy.

// PACKAGE MANAGERS: NPM VS. BOWER //

// JavaScript's ever-increasing modularity is of particular use to software
// engineers. Innumerable JavaScript libraries are available to developers as
// packages. There are libraries that offer everything from helper methods to
// various data structures to monolithic frontend frameworks. Also, there are
// plenty of humorous libraries.

// While some programmers are skeptical of the widespread use of libraries –
// perhaps rightfully so – the proliferation of package integration has likely
// led to significantly faster project development and production code that
// is both more stable and more secure.

// To handle project dependencies, a package manager has to be used. Two of
// the most commonly used package managers are npm(node package manager) and
// Bower. While npm is intended to handle Node.js dependencies, it is able to
// handle frontend dependencies – those that are sent to the client for use in
// the browser – as well. However, in order to allow for these frontend
// dependencies to be easily required, a bundling tool like Browserify or
// webpack has to be used.

// Bower, on the other hand, is designed specifically for managing frontend
// dependencies, so a bundling tool is not required. A key difference between
// npm and Bower lies in their treatment of conflicting dependencies.

// App Academy chooses to use npm with webpack. More information about its use
// can be found here. {https://docs.npmjs.com/}

// VOCABULARY //

// vanilla

// Vanilla is a term used to describe standard JavaScript without the use of
// additional frameworks or libraries. For example, the use of jQuery to
// make .ajax requests means that one is not using vanilla JavaScript.

// hoisting

// In JavaScript, declarations are hoisted by default. This means that
// variable and function declarations are put into memory at compile time.
// Therefore, it is actually possible, on execution, to call a declared
// function or variable before it is defined. For instance, the following
// will properly call the function sayHello.

console.log(sayHello()); // => 'hi!'

function sayHello() {
  return 'hi!';
}

// 'use strict';

// You will sometimes see this line at the top of JavaScript files. It is an
// instance of a special compiler directive called a pragma. This specific
// pragma ensures that the code in its scope follows certain rules, and if
// those rules are broken, errors will be thrown at compile time. For instance,
// strict mode prohibits the use of global variables. There are many other rules
// that are enforced in strict mode.

// IIFE

// An Immediately-Invoked Function Expression is a function that is called
// immediately after it is defined. For example, the following would run right
// after it is created:

(function() {
  console.log('testing');
})(); // => 'testing'

// jQuery

// jQuery is a free, open - source JavaScript library that allows its users to
// manipulate the DOM(Document Object Model).It was originally released in 2006,
// and it is now the most widely used JavaScript library on the Internet, being
// installed on 65 % of the ten million most - trafficked websites. jQuery
// includes both a variety of functions that can be called on jQuery objects and
// utility functions such as $.ajax().jQuery allows coders a slightly easier
// way, compared to vanilla JavaScript, to do almost everything - it's almost
// like coding in Ruby.

// jQuery's utility functions roughly mirror those provided by lodash.js.

// MEAN stack

// The MEAN stack is comprised of MongoDB, Express, Angular, and Node - all of
// which have a common base of JavaScript. This allows developers to write all
// of their code, from their database to their frontend, in JavaScript. MongoDB
// is a NoSQL database, Express is a "Sinatra-inspired server," Angular is a
// frontend MVC framework, and Node is the server-side JavaScript environment.

// functional programming

// JavaScript, with its treatment of functions as first-class objects, can be
// treated as a functional programming language without too much effort. One
// library that we will use heavily, Redux, uses several patterns and concepts
// from functional programming such as the currying pattern, pure functions,
// and avoiding the mutation of information. These ideas can be extended to
// encompass the entirety of a JavaScript program through the use of various
// libraries.

// Immutable.js, for example, is a library that makes every object immutable;
// to update an object's information, you are forced to replace it with a new
// object.

// POJO

// A POJO, or Plain Old JavaScript Object, is an object with attributes, getter
// methods, and setter methods. Since JavaScript objects allow access to their
// attributes via dot(obj.attr) and / or bracket(obj["attr"]) notation, any
// JavaScript object without additional methods is a POJO.

// The term comes from Java, with the "J" in the acronym originally having
// stood for "Java."
