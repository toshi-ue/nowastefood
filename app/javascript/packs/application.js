// import 'core-js/stable'
// import 'regenerator-runtime/runtime'

import 'jquery/dist/jquery'
// 原因1?
import Rails from 'rails-ujs/lib/assets/compiled/rails-ujs'
// import 'jquery-ui/ui/core'
// import 'jquery-ui/ui/widgets/sortable'
// import 'jquery-ui/sortable'
import 'popper.js/dist/umd/popper.min'
import 'bootstrap/dist/js/bootstrap'
import 'clipboard/dist/clipboard.min'
import '@fortawesome/fontawesome-free/js/all'
// import Sortable from 'sortablejs/modular/sortable.complete.esm.js'

Rails.start()
window.$ = window.jQuery = require('jquery');
require('data-confirm-modal')

/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// console.log('Hello World from Webpacker')



// import 'packs/managers/cuisines'
// console.log($(window).width())

$(function () {
  let xs = 0, sm = 576, md = 768, lg = 992, browserSize = 0, displaySizeText = ""

  function getBrowserWidth() {
    browserSize = $(window).width()
    // console.log(browserSize)
    if (browserSize >= lg) {
      displaySizeText = "lg (desktop " + browserSize + 'px)'
    } else if (browserSize >= md) {
      displaySizeText = "md (tablet " + browserSize + 'px)'
    } else if (browserSize >= sm) {
      displaySizeText = "sm (tablet " + browserSize + 'px)'
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
