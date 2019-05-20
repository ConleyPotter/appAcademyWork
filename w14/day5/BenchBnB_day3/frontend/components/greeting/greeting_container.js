import React from 'react';
import { connect } from 'react-redux';
import Greeting from './Greeting';
import { logOut } from '../../actions/session_actions';

const mapStateToProps = state => ({
  current_user: state.entities.users[state.session.current_user.id]
});

const mapDispatchToProps = dispatch => ({
  logOut: () => dispatch(logOut())
});

export default connect(mapStateToProps, mapDispatchToProps)(Greeting);