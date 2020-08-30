$(function () {

  let action_name = $('body').data('action')
  // console.log(action_name);

  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');

  let h_value_rawmaterial_id


  switch (action_name) {
    //   case "index":
    //     break;
    //   case "show":
    //     break;
    case "new":
    case "create":
      // check existence of cuisine_id
      // saveメソッドが失敗した時に実行してほしい
      h_value_rawmaterial_id = $('#foodstuff_rawmaterial_id').val()
      console.log(h_value_rawmaterial_id)
      if (h_value_rawmaterial_id) {
        $('#choiced_rawmaterial').show()
        $(".search_rawmaterial").hide()
      } else {
        $('#choiced_rawmaterial').hide()
      }

      // increamental search
      let preFunc = null;
      preInput = '';
      input = '';

      ajaxSearch = function () {
        $.ajax({
          type: 'GET',
          url: '/managers/foodstuffs/search_rawmaterial',
          data: { keyword: input },
          datatype: 'json'
        })
      }

      // search rawmaterial
      $("#search_rawmaterial").on("keyup", function () {
        input = $.trim($("#search_rawmaterial").val());
        if (preInput !== input) {
          clearTimeout(preFunc);
          setTimeout(ajaxSearch, 1000);
          console.log(input);
        }
        preInput = input;
        $('#search_results').show()
      })

      // get clicked-element(choice rawmaterial)
      $(document).on('click', 'div.rawmaterial', function () {
        // console.log(this)
        // console.log(this.dataset.unitName)
        // rawmaterial_idを取得
        let clicked_rawmaterial_id = parseInt((this.id).replace("rawmaterial_", ""))
        // rawmaterial_idを代入
        // console.log(this.textContent)
        $('#foodstuff_rawmaterial_id').val(clicked_rawmaterial_id)
        // 食材名をバッジt内に表示
        $('#rawmaterial_name').text(this.textContent)
        // バッジを表示
        $('#choiced_rawmaterial').show()
        // 数量フォームに単位を表示する
        $('.input-group-text').text(this.dataset.unitName)
        // 検索フォームを非表示にする
        $("#search_rawmaterial").hide()
        // 検索結果を非表示
        $('#search_results').hide()
        $('.rawmaterial').hide()
      })

      // reset choiced rawmaterial
      $("#btnResetRawmaterial").on("click", function () {
        // alert内の原材料名をクリアする
        $('#rawmaterial_name').text("")
        // 原材料idの値をクリアする
        $('#foodstuff_rawmaterial_id').val("")
        // 検索フォームをクリアする
        $('#search_rawmaterial').val("")
        // 数量フォームの単位をクリア
        $('.input-group-text').text("")
        // 検索フォームを表示する
        $('.search_rawmaterial').show()
        $('#search_rawmaterial').show()
        // 非表示する
        $('#choiced_rawmaterial').hide()
      })
      break;
    default:
      //     console.log("not passed");
      break;
  }
});
