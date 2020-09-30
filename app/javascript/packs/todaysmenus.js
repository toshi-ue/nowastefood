$(function () {
  const nabvarHeight = $(".navbar").outerHeight()
  const footerHeight = $(".page-footer").outerHeight()
  const htmlHeight = $("#index-todaysmenus").outerHeight()
  $("#no-todaysmenus").outerHeight(htmlHeight - nabvarHeight - footerHeight)

  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');
  $('[name="todaysmenu[serving_count]"').change(function () {
    let changedServingCount = parseInt($('[name="todaysmenu[serving_count]"').val())
    let cuisineID = parseInt($(this).data('cuisine-id'))
    let updateID = parseInt($(this).data('id'))
    let userID = parseInt($(this).data('user-id'))

    $.ajax({
      url: "/todaysmenus/" + updateID,
      type: "put",
      headers: {
        // 'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      data: {
        todaysmenu: {
          serving_count: changedServingCount,
          cuisine_id: cuisineID,
          user_id: userID
        },
      },
      dataType: "json"
    }).done(function (data) {
      console.log("success")
    }).fail(function () {
      console.log("error")
    })
  })
});
