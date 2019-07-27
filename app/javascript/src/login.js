// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'

import LoginForm from 'components/login-form'

const App = () => (
  <LoginForm />
)


const startApp = () => {
  const root = document.getElementById('react-root')
  if (root) {
    ReactDOM.render(<App />, root)
  }
}

export default startApp
