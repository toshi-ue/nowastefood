$(function () {
  const nabvarHeight = $(".navbar").outerHeight()
  const footerHeight = $(".page-footer").outerHeight()
  const htmlHeight = $("#index-favorites").outerHeight()
  $("#no-favorites").outerHeight(htmlHeight - nabvarHeight - footerHeight)
});
