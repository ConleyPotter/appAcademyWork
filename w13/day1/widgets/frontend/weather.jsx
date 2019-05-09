import React from "react";

class Weather extends React.Component {
  constructor(props) {
    super(props);
    this.state = { weatherData: null };
  }

  componentDidMount() {
    this.location = navigator.geolocation.getCurrentPosition( (position) => {
      const xhr = new XMLHttpRequest();
      xhr.onreadystatechange = () => {
        if (xhr.readyState == XMLHttpRequest.DONE) {
          if (xhr.status == 200) {
            this.setState( 
              { weatherData: 
                  this.parseWeatherData(xhr.responseText) 
              });
          } else {
            console.log(xhr.responseText);
          }
        }
      };
      xhr.open(
        "GET",
        `http://api.openweathermap.org/data/2.5/weather?lat=${
          position.coords.latitude
        }&lon=${
          position.coords.longitude
        }&appid=bcb83c4b54aee8418983c2aff3073b3b`,
        true
      );
      xhr.send();
    });
  }

  render() {
    return (
      <div className="weather">
        <h2>{this.state.weatherData}</h2>
      </div>
    )
  }

  parseWeatherData(weatherData) {
    const parsedWeather = JSON.parse(weatherData);
    const condition = parsedWeather.weather[0].description;
    const temperature = Math.floor((parsedWeather.main.temp - 272) * (9/5) + 32);
    return `${temperature} degrees and ${condition}`;
  }
}

export default Weather;

// $.ajax({
//     type: 'GET',
//     url: 'http://api.openweathermap.org/data/2.5/weather?q=new%20york,US&appid=bcb83c4b54aee8418983c2aff3073b3b',
//   success(data) {
//     console.log(data);
//   },
//   error() {
//     $.ajax({
//       type: 'GET', 
//       url: 'http://api.openweathermap.org/data/2.5/weather?q=new%20york,US&appid=7da4aefdc9255632d6849b4266b01103',
//       success(data) {
//         console.log(data);
//       },
//       error (errMsg) {
//         console.log(errMsg);
//       },
//     });
//   },
// });