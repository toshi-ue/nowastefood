// TODO: 後でコメント,console.logを削除
// import Sortable from 'sortablejs';
import 'jquery-ui/ui/widgets/sortable';

$(function () {
  let action_name = $('body').data('action')

  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');

  switch (action_name) {
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
    case "new":
      // TODO: 画像プレビューを実装する
      // [画像の複数投稿？？プレビュー表示？？え？？ - Qiita](https://qiita.com/gakinchoy7/items/f52577d0c5f6b2edff89)
      // form.file_fieldを取得
      let file_field = document.querySelector('input[name="cuisine[main_image]"]')
      console.log(file_field)
      console.log($('#img-file'))
      $('#img-file').change(function () {
        let file = $('input[type="file').prop('files')[0]
        console.log(file)
      })
      break;
    default:
      console.log("not passed");
      break;
  }
});
