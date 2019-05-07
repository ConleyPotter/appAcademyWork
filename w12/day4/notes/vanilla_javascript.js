// Vanilla, in the context of coding, means using a language or library without
// additional enhancements. In this case, Vanilla JavaScript, would be
// JavaScript without any additional libraries (jQuery in our case).

// WHY NOT JQUERY? //

// Throughout this course we will continue to use jQuery with Rails. This is
// primarily because of the handy jquery-rails gem, which provides us both
// jquery and jquery_ujs. jquery gives us the standard jQuery library,
// and jquery_ujs monkey-patches our AJAX requests to include the Rails CSRF
// token (the same functionality as the rails-ujs gem that comes bundled
// with Rails).

// Though jQuery integrates nicely with Rails, there will come a time in your
// illustrious coding career that you cannot use jQuery. There are a few reasons
// we may want to utilize "vanilla" DOM manipulation:

// 1. jQuery is a very thorough library, with a lot of nice, syntactic sugar,
//    but that comes with a cost. jQuery, though not huuuge, is a considerably
//    sized resource that will need to be loaded with the rest of our application
//    code. If speed is our goal, we may want to use the API provided to us by
//    the browser.

// 2. You just don't need it. Maybe you are only doing a little bit of simple
//    DOM manipulation in your app and can suffice without jQuery.

// 3. The company that pays you money doesn't like it. ¯\_(ツ)_/¯

// So, let's learn a few things about DOM manipulation with vanilla JavaScript.

// SO HOW DO I USE VANILLA JAVASCRIPT //

// Fortunately for us, MDN provides an excellent source of documentation for
// all things JavaScript, including the DOM.

// Much of working with vanilla JavaScript is looking through the docs.
// We can't provide you with a vanilla code snippet for every jQuery method,
// but we can give you a few starting points.

// DOM ELEMENTS //

// Firstly, we need to understand what kind of objects we will be working with.
// There are three main classes we will be working with:

// - Node - the basic element representing a "node" on the DOM
// - Element - inherits from Node; each element on the Document is a decendent
//   of Element
// - HTMLElement - inherits from Element, but more specifically represent
//   HTML elements (those created from an HTML tag)
//    - HTMLCollection - an array-like object containing a collection of
//      HTMLElement
// - Document - the root element of our page, serves as an entry point to the
//   content in our page (HTML elements, JS, browser events, etc.)

// FUNCITONALITY //

// So, if we want to select something from the page, we would start by calling
// a method on document, (an instance of Document and Element) and return
// either an HTMLElement or HTMLCollection depending upon whether we searched
// broadly (class name, tag name) or specifically (id). From the returned
// items, we can do more sub-selection, assign event handlers, or mutate
// elements.

// A few methods to get you started:

// - document.getElementById
// - Element.getElementsByClassName
// - Element.querySelectorAll
// - EventTarget.addEventListener
// - Node.appendChild
// - Node.removeChild

// Remember to look through the docs to determine what your return value will
// be and find even more specific/helpful methods.

// NB: Although we will mostly be working with HTMLElement objects, many of
// the methods we need for selection and mutation may be defined on the
// ancestor classes, Element or Node.

// WHY DO WE (AND RAILS) LIKE $.ajax SO MUCH? //

// The reasons we like jQuery for AJAX requests are:

// 1. Using jQuery and jquery-ujs/rails-ujs together will automatically handle
//    CSRF tokens for us.
// 2. jQuery will automatically transform JSON (which is a string) into
//    JavaScript objects. If we use XHR (the vanilla-DOM way), we have to
//    handle this ourselves.
// 3. jQuery's API is much more user-friendly than XHR.

// Although we will usually rely on jQuery, you may be asked about non-jQuery
// AJAX requests in interviews or if you end up working with a stack that
// doesn't rely on jQuery. Therefore it is important to know how to use
// vanilla DOM.

// Check out AJAXTwitter's UserSearch class with Vanilla JavaScript to see how
// these and other methods might be used.

// XMLHttpRequest //

// The functionality of AJAX is accomplished though something called an 
// XMLHttpRequest object(aka XHR).The steps to make an XHR request are:
// 1. Create a XHR object.
// 2. Tell it where to go and what verb to use ('Get', 'Post', etc).
// 3. Tell it what to do when it's finished loading (register a callback).
// 4. Send off the request (with optional data).

// Let's see an example:

// step 1 - create xhr object
const xhr = new XMLHttpRequest();

// step 2 - specify path and verb
xhr.open('POST', 'api/path/to/resource');

// step 3 - register a callback
xhr.onload = function() {
  console.log(xhr.status); // for status info
  console.log(xhr.responseType); // the type of data that was returned
  // the actual response. For JSON api calls, this will be a JSON string
  console.log(xhr.response);
};

// step 4 - send off the request with optional data
const optionalData = {name: 'User1', password: '123456'};
xhr.send(optionalData);

// Check out the MDN Documentation for more information.