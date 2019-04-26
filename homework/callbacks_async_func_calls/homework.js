function timeOutFn () {
  window.setTimeout(alertFn, 5000);
  console.log("Timer set!");
}

function alertFn () {
  alert('HAMMERTIME');
}

function hammerTime (time) {
  window.setTimeout(function () {
    alert(`${time} is hammertime!`);
  }, 5000);
}