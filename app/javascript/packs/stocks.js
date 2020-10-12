$(function () {
  console.log("stocks")
  // app/javascript/packs/managers/foodstuffs.js と同じ処理がしたい
  let action_name = $('body').data('action')
  console.log(action_name);

  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');

  switch (action_name) {
    case "new":
      // initialize
      $('#choiced_rawmaterial').hide()
      $('#rawmaterial_name').hide()
      $("#btnResetRawmaterial").hide()

      // check existence of cuisine_id
      // let initial_rawmaterial_id = $('#stock_rawmaterial_id').val()
      // console.log(initial_rawmaterial_id)

      // if (initial_rawmaterial_id) {
      //   $('#choiced_rawmaterial').show()
      //   $('#rawmaterial_name').show()
      //   $("#btnResetRawmaterial").show()
      //   $(".search_rawmaterial").hide()
      //   $("#search_rawmaterial").hide()
      // }

      // increamental search
      let preFunc = null;
      preInput = '';
      input = '';

      ajaxSearch = function () {
        $.ajax({
          type: 'GET',
          url: '/stocks/search_rawmaterial',
          data: {
            keyword: input
          },
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
        // rawmaterial_idを取得
        let clicked_rawmaterial_id = parseInt((this.id).replace("rawmaterial_", ""))
        // rawmaterial_idを代入
        console.log(this.textContent)
        $('#stock_rawmaterial_id').val(clicked_rawmaterial_id)
        // 食材名をalert内に表示
        $('#rawmaterial_name').text(this.textContent)
        // alertを表示
        $('#choiced_rawmaterial').show()
        $('#rawmaterial_name').show()
        $("#btnResetRawmaterial").show()
        // 数量フォームに単位を表示する
        $('.input-group-text').text(this.dataset.unitName)
        // 検索フォームを非表示にする
        $("#search_rawmaterial").hide()
        $("#label_keyword").hide()
        // 検索結果を非表示
        $('#search_results').hide()
        $('.rawmaterial').hide()
      })

      // reset choiced rawmaterial
      $("#btnResetRawmaterial").on("click", function () {
        // alertの背景色を変更する- 動作確認
        // $('#choiced_rawmaterial').css('background-color', 'Red')
        // alert内の原材料名をクリアする
        $('#rawmaterial_name').text("")
        // 原材料idの値をクリアする
        $('#stock_rawmaterial_id').val("")
        // 検索フォームをクリアする
        $('#search_rawmaterial').val("")
        // 数量フォームの単位をクリア
        $('.input-group-text').text("")
        // 検索フォームを表示する
        $("#label_keyword").show()
        $('.search_rawmaterial').show()
        $('#search_rawmaterial').show()
        // 非表示する
        $('#choiced_rawmaterial').hide()
        $("#btnResetRawmaterial").hide()
        console.log("11")
      })
      break;
    default:
      // console.log("not passed");
      break;
  }
});
