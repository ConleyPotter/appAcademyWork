import React from "react";

class Tabs extends React.Component {
  constructor(props) {
    super(props);
    this.state = { tabIndex: 0 };
    this.click = this.click.bind(this);
  }

  click(idx) {
    this.setState( { tabIndex: idx } );
  }

  render() {
    return (
      <div>
        <ul className="tabs-list">
          <li onClick={() => this.click(0)} id="0">
            <h1>Uno</h1>
            <article>Something</article>
          </li>
          <li onClick={() => this.click(1)} id="1">
            <h1>Dos</h1>
            <article>Something Else</article>
          </li>
          <li onClick={() => this.click(2)} id="2">
            <h1>Tres</h1>
            <article>Something Weird</article>
          </li>
        </ul>
      </div>
    )
  }

}

export default Tabs;