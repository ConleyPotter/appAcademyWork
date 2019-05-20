import React from 'react'
import ReactDOM from 'react-dom'
import configureStore from './store/store'
import Root from './components/root'
import * as sessionActions from './actions/session_actions'
import * as benchActions from './actions/bench_actions'

document.addEventListener('DOMContentLoaded', () => {
  const root = document.getElementById('root')
  let store
  if (window.current_user) {
    const preloadedState = {
      entities: {
        users: { [window.current_user.id]: window.current_user }
      },
      session: {
        current_user: window.current_user
      }
    }
    store = configureStore(preloadedState)
    delete window.current_user
  } else {
    store = configureStore()
  }

  // testing
  window.login = sessionActions.logIn
  window.getState = store.getState
  window.dispatch = store.dispatch
  window.fetchBenches = benchActions.fetchBenches

  ReactDOM.render(<Root store={store}/>, root)
})
