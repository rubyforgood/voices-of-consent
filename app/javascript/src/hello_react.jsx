// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { useState } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const Hello = (props) => {
  const [count, setCount] = useState(0);
  return (
    <div className="row">
      <div className="col-sm">
        <p>
          Oh, hello {props.name}!
        </p>
        <p>
          <span>{count}</span> <button onClick={() => setCount(count + 1)}>+</button>
        </p>
      </div>
    </div>
  )
}

Hello.defaultProps = {
  name: 'Something'
}

Hello.propTypes = {
  name: PropTypes.string
}

const startApp = () => {
  const root = document.getElementById('react-root')
  if (root) {
    ReactDOM.render(<Hello name="React" />, root)
  }
}

document.addEventListener('DOMContentLoaded', startApp)
document.addEventListener('turbolinks:load', startApp)
