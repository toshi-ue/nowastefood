import 'select2'
import 'select2/dist/css/select2.css'
import '@ttskch/select2-bootstrap4-theme/dist/select2-bootstrap4.min.css'

$(function () {
  let action_name = $('body').data('action')
  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');

  if ($('#stock_rawmaterial_id option:selected').val()) {
    $.ajax({
      type: 'GET',
      url: '/stocks/search_unit_and_expiry_period',
      data: { id: $('#stock_rawmaterial_id option:selected').val() },
      dataType: 'json'
    }).done(function (data) {
      $(".input-group-text").text(data.unit_name)
      $("#expiry_period").text(data.expiry_period + "日")
    }).fail(function () {
      console.log("could not get unit name.")
    })
  }

  switch (action_name) {
    case "new":
    case "create":
      console.log(action_name)
      $("#stock_rawmaterial_id").select2();
      $("#stock_rawmaterial_id").select2({
        ajax: {
          url: '/stocks/search_rawmaterial',
          datatype: 'json',
          delay: 500,
          data: function (params) {
            return { q: params.term }
          },
          processResults: function (data, params) {
            return {
              results: $.map(data, function (obj) {
                return { id: obj.id, text: obj.name };
              })
            };
          }
        },
        placeholder: "入力してください",
        theme: 'bootstrap4',
      })

      $("#stock_rawmaterial_id").on('select2:select', function (e) {
        let rawmaterial_id = e.params.data.id
        $(".input-group-text").text("")
        $("#expiry_period").text("")
        $.ajax({
          type: 'GET',
          url: '/stocks/search_unit_and_expiry_period',
          data: { id: rawmaterial_id },
          dataType: 'json'
        }).done(function (data) {
          $(".input-group-text").text(data.unit_name)
          $("#expiry_period").text(data.expiry_period + "日")
        }).fail(function () {
          console.log("could not get unit name.")
        })
      })
      break;
    default:
      break;
  }
});
