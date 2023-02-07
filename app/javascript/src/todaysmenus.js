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

  $('#cooked_when_1').parent("label").css("color", "#FFFFFF")
  $('[name="cooked_when"]').change(function(){
    console.log($('#cooked_when_' + this.value).parent("label").text())
    $('[name="cooked_when"]').parent("label").css("color", "#E0A800")
    $('#cooked_when_' + this.value).parent("label").css("color", "#FFFFFF")
  })
});
