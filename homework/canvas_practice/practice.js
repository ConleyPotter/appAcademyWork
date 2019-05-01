document.addEventListener("DOMContentLoaded", function(){
  // rectangle:
  const canvas = document.getElementById('mycanvas');
  const ctx = canvas.getContext('2d');
  ctx.fillStyle = 'red';
  ctx.fillRect(20, 10, 150, 100);

  // circle: 
  ctx.beginPath();
  ctx.arc(200, 200, 20, 0, 180);
  ctx.strokeStyle = 'blue';
  ctx.lineWidth = 10;
  ctx.stroke();
  ctx.fillStyle = 'blue';
  ctx.fill();

  // favorite shape:
});
