import React from 'react'
import { Route } from 'react-router-dom'
import GreetingContainer from './greeting/greeting_container'
import LogInFormContainer from './auth/login_form_container'
import SignUpFormContainer from './auth/signup_form_container'
import { AuthRoute } from '../util/route_util'
import SearchContainer from '../components/search/search_container'

const App = () => (
  <div>
    <header>
      <h1>Bench BnB</h1>
      <GreetingContainer />
    </header>
    <AuthRoute path="/login" component={LogInFormContainer} />
    <AuthRoute path="/signup" component={SignUpFormContainer} />
    <Route exact path="/" component={ SearchContainer } />
  </div>
)

export default App
