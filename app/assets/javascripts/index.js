import App from './app.jsx'
import {render} from 'react-dom'
import $ from 'jquery'

$(document).ready(() => {
  console.log(document.getElementById('container'));
  render(<App/>, document.getElementById('container'))
})
