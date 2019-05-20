import React from 'react'
import { connect } from 'react-redux'
import SessionForm from './session_form'
import { logIn } from '../../actions/session_actions'

const mapStateToProps = (state, ownProps) => ({
  errors: state.session.errors,
  formType: 'Log In'
})

const mapDispatchToProps = (dispatch, ownProps) => ({
  processForm: (user) => dispatch(logIn(user))
})

export default connect(mapStateToProps, mapDispatchToProps)(SessionForm)
