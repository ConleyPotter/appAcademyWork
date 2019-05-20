import React from 'react';
import { Link } from 'react-router-dom';

class SessionForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {username: "", password: ""};
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleInput = this.handleInput.bind(this);
  }

  handleSubmit(e) {
    e.preventDefault();
    const user = Object.assign({}, this.state);
    this.props.processForm(user);
  }

  handleInput(type) {
    return (e) => {
      this.setState({ [type]: e.target.value });
    };
  }

  render () {
    let linkTo = this.props.formType == "Log In" ? "/login" : "/signup";
    // come back to redirect to "/" if needed
    return (
      <div>
        {/* <Link to={linkTo}>{this.props.formType}</Link> */}
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
            Password:
            <input
              type="password"
              value={this.state.password}
              onChange={this.handleInput('password')}
            />
          </label>
          <button onSubmit={e => handleSubmit(e)}>Submit</button>
        </form>
        <ul>
          {this.props.errors}
        </ul>
      </div>
    )

  }

}

export default SessionForm;
