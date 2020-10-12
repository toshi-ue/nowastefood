import 'jquery/dist/jquery'
import Rails from 'rails-ujs/lib/assets/compiled/rails-ujs'
import 'popper.js/dist/umd/popper.min'
import 'bootstrap/dist/js/bootstrap'
import 'clipboard/dist/clipboard.min'
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
window.$ = window.jQuery = require('jquery');
require('data-confirm-modal')


$(function () {
  let xs = 0,
    sm = 576,
    md = 768,
    lg = 992,
    xl = 1200,
    browserSize = 0,
    displaySizeText = ""

  function getBrowserWidth() {
    browserSize = $(window).width()
    // console.log(browserSize)
    if (browserSize >= xl) {
      displaySizeText = "xl (desktop " + browserSize + 'px)'
    } else if (browserSize >= lg) {
      displaySizeText = "lg (desktop " + browserSize + 'px)'
    } else if (browserSize >= md) {
      displaySizeText = "md (tablet " + browserSize + 'px)'
    } else if (browserSize >= sm) {
      displaySizeText = "sm (mobile landscope" + browserSize + 'px)'
    } else {
      displaySizeText = "xs (mobile " + browserSize + 'px)'
    }
    // console.log(displaySizeText)
    $('#browserWidth').html(displaySizeText)
  }

  getBrowserWidth()

  $(window).resize(function () {
    getBrowserWidth()
  });
});
