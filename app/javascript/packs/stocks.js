import 'select2'
import 'select2/dist/css/select2.css'
import '@ttskch/select2-bootstrap4-theme/dist/select2-bootstrap4.min.css'

$(function () {
  let action_name = $('body').data('action')
  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');

  switch (action_name) {
    case "new":
      $(".selectfa").select2({
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
        theme: 'bootstrap4',
      })

      $(".selectfa").on('select2:select', function (e) {
        let rawmaterial_id = e.params.data.id
        $(".input-group-text").text("")
        $.ajax({
          type: 'GET',
          url: '/stocks/unit_search',
          data: { rm_id: rawmaterial_id },
          dataType: 'json'
        }).done(function (data) {
          $(".input-group-text").text(data.name)
        }).fail(function () {
          console.log("could not get unit name.")
        })
      })
      break;
    default:
      break;
  }
});
