$(document).ready(function () {
  $("#tab-foodstuff").css("font-weight", "bold");

  $('a[data-toggle="tab"]').on('click', function (e) {
    let clickedTab = $(e.target).attr("id")
    if (clickedTab === "tab-procedure") {
      $("#tab-procedure").css("font-weight", "bold");
      $("#tab-foodstuff").css("font-weight", "normal");
    } else {
      $("#tab-foodstuff").css("font-weight", "bold");
      $("#tab-procedure").css("font-weight", "normal");
    }
  })

});

console.log("loaded in app/assets/javascripts/users/cuisines.js")
