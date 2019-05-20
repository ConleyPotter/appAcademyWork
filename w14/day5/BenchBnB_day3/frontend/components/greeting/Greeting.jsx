import React from 'react';
import { Link } from 'react-router-dom';

const Greeting = ({ current_user, logOut }) => {
  if (current_user) {
    return (
      <div>
        <h1>Welcome {current_user.username}</h1>
        <button onClick={logOut}>Log Out</button>
      </div>
    )
  } else {
    return (
      <div>
        <Link to="/signup">Sign Up</Link>
        <Link to="/login">Log In</Link>
      </div>
    );
  }
};

export default Greeting;











// class Greeting extends React.Component {
//   constructor(props) {
//     super(props);
//     this.state = {current_user: this.props.current_user};
//   }

//   render() {
//     let toRender;
//     if (this.props.current_user) {
//       toRender = (
//         <div>
//           <h1>Welcome {this.props.current_user.username}</h1>
//           <button onClick={this.props.logOut}>Log Out</button>
//         </div>
//       )
//     } else {
//       toRender = (
//         <div>
//           <Link to="/signup">Sign Up</Link>
//           <Link to="/login">Log In</Link>
//         </div>
//       );
//     }
//     return (
//       <div>
//         {toRender}
//       </div>
//     )
//   }
// }

// export default Greeting