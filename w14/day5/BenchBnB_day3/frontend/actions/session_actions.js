import * as APIUtil from '../util/session_api_util';
export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER';
export const REMOVE_CURRENT_USER = 'REMOVE_CURRENT_USER';
export const RECEIVE_ERRORS = 'RECEIVE_ERRORS';

const receiveCurrentUser = (current_user) => {
  return {
    type: RECEIVE_CURRENT_USER,
    current_user
  }
};

const logOutCurrentUser = () => ({
  type: REMOVE_CURRENT_USER
})

const receiveErrors = errors => ({
  type: RECEIVE_ERRORS,
  errors
})

export const logIn = user => dispatch => (
  APIUtil.logIn(user)
    .then(user => dispatch(receiveCurrentUser(user)))
)

export const logOut = () => dispatch => (
  APIUtil.logOut()
    .then(() => dispatch(logOutCurrentUser()))
)

export const signUp = user => dispatch => (
  APIUtil.signUp(user)
    .then(user => dispatch(receiveCurrentUser(user)))
)
