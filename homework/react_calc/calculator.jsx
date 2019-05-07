import React from 'react';

class Calculator extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      result: 0,
      num1: '',
      num2: '',
    };
    this.setNum1 = this.setNum1.bind(this);
    this.setNum2 = this.setNum2.bind(this);
    this.add = this.add.bind(this);
    this.subtract = this.subtract.bind(this);
    this.multiply = this.multiply.bind(this);
    this.divide = this.divide.bind(this);
    this.clear = this.clear.bind(this);
  }

  setNum1(e) {
    this.setState({ num1: 
      parseInt(!!e.currentTarget.value ? e.currentTarget.value : '0') 
    });
  }

  setNum2(e) {
    this.setState({ num2: 
      parseInt(!!e.currentTarget.value ? e.currentTarget.value : '0') 
    });
  }

  add(e) {
    e.preventDefault();
    this.setState({ result: (this.state.num1 + this.state.num2) });
  }

  subtract(e) {
    e.preventDefault();
    this.setState({ result: (this.state.num1 - this.state.num2 )});
  }

  multiply(e) {
    e.preventDefault();
    this.setState({ result: (this.state.num1 * this.state.num2) });
  }

  divide(e) {
    e.preventDefault();
    this.setState({ result: (this.state.num1 / this.state.num2) });
  }

  clear(e) {
    e.preventDefault();
    this.setState({ num1: '', num2: '' });
  }

  render() {
    return (
      <div>
        <input onChange={this.setNum1} value={this.state.num1} />
        <input onChange={this.setNum2} value={this.state.num2} />
        <button onClick={this.add}>+</button>
        <button onClick={this.subtract}>-</button>
        <button onClick={this.multiply}>*</button>
        <button onClick={this.divide}>/</button>
        <button onClick={this.clear}>Clear</button>
        <h1>The result is: {this.state.result}</h1>
      </div>
    );
  }
}

export default Calculator;