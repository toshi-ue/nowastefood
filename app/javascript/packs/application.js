// import 'stylesheets/application'
import 'jquery/dist/jquery'
import Rails from 'rails-ujs/lib/assets/compiled/rails-ujs'
import 'popper.js/dist/umd/popper.min'
import 'bootstrap/dist/js/bootstrap'
import '@fortawesome/fontawesome-free/js/all'

Rails.start()
window.$ = window.jQuery = require('jquery');
require('data-confirm-modal')

// tooltips
// 各ページに独自のtooltipクラスを指定しないとデザインが崩れる
$(function () {
  $('.add-todaysmenu-tooltip').tooltip();
  $('.add-recipes-cookinghistorys-tooltip').tooltip();
  $('.autotoday-tooltip').tooltip();
  $('.delete-favorite-tooltip').tooltip();
  $('.favorites-tooltip').tooltip();
  $('.histories-tooltip').tooltip();
  $('.manager-cuisine-tooltip').tooltip();
  $('.manager-cuisines-tooltip').tooltip();
  $('.manager-foodcategories-tooltip').tooltip();
  $('.preview-tooltip').tooltip();
  $('.remove-cookinghistorys-tooltip').tooltip();
  $('.remove-todaysmenus-tooltip').tooltip();
  $('.stocks-tooltip').tooltip();
  $('.todaysmenus-tooltip').tooltip();
});
