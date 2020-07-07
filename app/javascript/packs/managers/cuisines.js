// import Sortable from 'sortablejs';
import 'jquery-ui/ui/widgets/sortable';

$(document).ready(function () {
  // let action_name = $('body').data('action')
  // console.log(action_name)
});

$(function () {
  let action_name = $('body').data('action')
  console.log(action_name)

  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');

  switch(action_name){
    case "index":
      break;
    case "show":
      // procedure
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
          console.log(item_data.update_url);
          console.log(params)

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

      // foodstuff
      $('#table-sortable-foodstuff').sortable({
        axis: 'y',
        items: '.foodstuff',
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
          console.log(item_data.update_url);
          console.log(params);

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
      break;
    default:
      console.log("not passed");
      break;
  }
});
