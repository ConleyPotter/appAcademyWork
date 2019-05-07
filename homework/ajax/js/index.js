console.log("Hello from the JavaScript console!");

// Your AJAX request here
$.ajax({
  type: 'GET',
  url: 'http://api.openweathermap.org/data/2.5/weather?q=new%20york,US&appid=bcb83c4b54aee8418983c2aff3073b3b',
  success(data) {
    console.log(data);
  },
  error() {
    $.ajax({
      type: 'GET', 
      url: 'http://api.openweathermap.org/data/2.5/weather?q=new%20york,US&appid=7da4aefdc9255632d6849b4266b01103',
      success(data) {
        console.log(data);
      },
      error (errMsg) {
        console.log(errMsg);
      },
    });
  },
});
// Add another console log here, outside your AJAX request
console.log('hello from after the ajax!');
