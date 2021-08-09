import 'jquery/dist/jquery'
import Rails from 'rails-ujs/lib/assets/compiled/rails-ujs'
import 'popper.js/dist/umd/popper.min'
import 'bootstrap/dist/js/bootstrap'
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
window.$ = window.jQuery = require('jquery');
require('data-confirm-modal')
