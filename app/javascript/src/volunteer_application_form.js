import React from 'react'
import ReactDOM from 'react-dom'

import VolunteerApplicationForm from 'components/volunteer-application-form'

const App = () => (
  <VolunteerApplicationForm />
)


const startApp = () => {
  const root = document.getElementById('react-root')
  if (root) {
    ReactDOM.render(<App />, root)
  }
}

export default startApp
