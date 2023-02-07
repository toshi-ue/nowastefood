import 'jquery-ui/ui/widgets/sortable';

$(function () {
  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');
  // console.log(csrfToken)
  $('#table-sortable-procedure').sortable({
    axis: 'y',
    items: '.procedure',
    update: function (e, ui) {
      var item, item_data, params;
      item = ui.item;
      item_data = item.data();
      params = {
        _method: 'put'
      };
      // parameterを作成
      params[item_data.model_name] = {
        row_order_position: item.index()
      };
      params = JSON.stringify(params);

      return $.ajax({
        type: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        url: item_data.update_url,
        dataType: 'json',
        data: params
      });
    }
  });
})
