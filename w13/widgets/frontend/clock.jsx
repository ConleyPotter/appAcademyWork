import React from "react";

class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = { time: new Date() };
    this.tick = this.tick.bind(this);
  }

  tick() {
    this.setState( { time: new Date() } );
  }

  render() {
    return (
      <div className="clock">
        <div className="time">
          <h1>Time:</h1>
          <h1>{this.parseTime(this.state.time)}</h1>
        </div>
        <div className="date">
          <h1>Date:</h1>
          <h1>{this.parseDate(this.state.time)}</h1>
        </div>
      </div>
    )
  }

  componentDidMount() {
    this.interval = setInterval(this.tick, 1000);
  }

  componentWillUnmount() {
    clearInterval(this.interval);
  }

  parseTime(dateObj) {
    const hours = dateObj.getHours();
    const minutes = dateObj.getMinutes();
    const seconds = dateObj.getSeconds();

    return `${hours}:${minutes}:${seconds}`;
  }

  parseDate(dateObj) {
    const year = dateObj.getYear();
    const month = dateObj.getMonth();
    const day = dateObj.getDay();

    return `${year} ${month} ${day}`;
  }
}

export default Clock;