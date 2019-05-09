import React from 'react';

class Autocomplete extends React.Component {
  constructor(props) {
    super(props);
    this.state = { inputVal: '' };
    this.changeUl = this.changeUl.bind(this);
  }

  changeUl(event) {
    this.setState( { inputVal: event.currentTarget.value } );
    // only render the list item that starts with inputVal
    // 
  }

  render() {
    const listNames = this.props.names.map( (name, idx) => {
      return (
        <li key={idx}>{name}</li>
      );
    });

    return (
      <div>
        <input type="text" onChange={(event) => this.changeUl(event)}/>
        <ul>
          {listNames}
        </ul>
      </div>
    );
  }
}

export default Autocomplete;