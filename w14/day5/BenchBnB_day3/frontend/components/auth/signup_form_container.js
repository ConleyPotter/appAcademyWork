import React from 'react';
import { connect } from 'react-redux';
import SessionForm from './session_form';
import { signUp } from '../../actions/session_actions';

const mapStateToProps = (state, ownProps) => ({
  errors: state.session.errors,
  formType: "Sign Up"
});

const mapDispatchToProps = (dispatch, ownProps) => ({
  processForm: (user) => dispatch(signUp(user))
});

export default connect(mapStateToProps, mapDispatchToProps)(SessionForm);