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
    case "create":
    case "edit":
    case "new":
      console.log("passed")
      $(document).on('change', 'input[type="file"]', function(){
        let files = !!this.files ? this.files : [];
        let input_file_upload = $(this);
        let uploaded_file_name = input_file_upload.val().replace(/\\/g, '/').replace(/.*\//, '');
        $("#image_name").val(uploaded_file_name);

        if(!files.length || !window.FileReader) return;
        if (/^image/.test(files[0].type)){
          let reader = new FileReader();
          reader.onload = function(){
            $("#no_cuisine_image").attr('src', this.result)
          }
          reader.readAsDataURL(files[0]);
        }

      })
      break;
    default:
      console.log("not passed");
      break;
  }
});
