$(function () {
  const userTabHeight = $("#tab-1").outerHeight()
  $("#tab-2").outerHeight(userTabHeight)

  $("#user-tab").css("font-weight", "bold");

  $("#admin-tab").click(function () {
    $("#admin-tab").css("font-weight", "bold");
    $("#user-tab").css("font-weight", "normal");
  })

  $("#user-tab").click(function () {
    $("#user-tab").css("font-weight", "bold");
    $("#admin-tab").css("font-weight", "normal");
  })
});
