/* eslint-disable react/destructuring-assignment */
/* eslint-disable react/prop-types */
/* eslint-disable jsx-a11y/label-has-associated-control */
/* eslint-disable jsx-a11y/label-has-for */
/* eslint-disable react/button-has-type */
/* eslint-disable react/prefer-stateless-function */
import React from 'react';

class Signup extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      username: '',
      email: '',
      password: '',
    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleInput = this.handleInput.bind(this);
  }

  handleInput(type) {
    return (e) => {
      this.setState({ [type]: e.target.value });
    };
  }

  handleSubmit(e) {
    e.preventDefault();
    // eslint-disable-next-line react/destructuring-assignment
    this.props.createNewUser(this.state)
      .then(() => this.props.history.push('/chirps'));
  }

  render() {
    return (
      <div>
        <h2>Sign Up!</h2>
        <form onSubmit={this.handleSubmit}>
          <label>
            Username:
            <input
              type="text"
              value={this.state.username}
              onChange={this.handleInput('username')}
            />
          </label>
          <label>
            Email:
            <input
              type="text"
              value={this.state.email}
              onChange={this.handleInput('email')}
            />
          </label>
          <label>
            Password:
            <input
              type="password"
              value={this.state.password}
              onChange={this.handleInput('password')}
            />
          </label>
          <button>Sign Up</button>
        </form>
      </div>
    );
  }
}

export default Signup;
