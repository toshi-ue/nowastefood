import 'jquery/dist/jquery'
import Rails from "@rails/ujs"
import 'popper.js/dist/umd/popper.min'
import 'bootstrap/dist/js/bootstrap'
import '@fortawesome/fontawesome-free/js/all'
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()
window.$ = window.jQuery = require('jquery');
require('data-confirm-modal')

// https://railsguides.jp/webpacker.html#%E9%9D%99%E7%9A%84%E3%82%A2%E3%82%BB%E3%83%83%E3%83%88%E3%82%92webpacker%E7%B5%8C%E7%94%B1%E3%81%A7%E5%88%A9%E7%94%A8%E3%81%99%E3%82%8B
// https://qiita.com/ren0826jam/items/1baa6d1fd439ef9c047f#%E9%9D%99%E7%9A%84%E3%82%A2%E3%82%BB%E3%83%83%E3%83%88%E3%82%92webpacker%E7%B5%8C%E7%94%B1%E3%81%A7%E5%88%A9%E7%94%A8%E3%81%99%E3%82%8B
const images = require.context("../images", true)
const imagePath = name => images(name, true)

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
  $('.preview-disabled-tooltips').tooltip();
});
