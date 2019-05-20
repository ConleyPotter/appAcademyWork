import { RECEIVE_CURRENT_USER, REMOVE_CURRENT_USER, RECEIVE_ERRORS } from '../actions/session_actions';

const _nullSession = {
  current_user: {
    id: null,
  }
};

export default (state = _nullSession, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_CURRENT_USER:
      return Object.assign({}, {current_user: action.current_user});
    case REMOVE_CURRENT_USER:
      return _nullSession;
    // case RECEIVE_ERRORS:
    //   return Object.assign({}, {errors: action.errors});
    default:
      return state;
  }
};