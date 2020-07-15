$(function () {
  let action_name = $('body').data('action')
  console.log(action_name);

  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');

  switch (action_name) {
    case "index":
      break;
    case "show":
      break;
    case "new":
      // initialize
      $('#choiced_rawmaterial').hide()
      $('#rawmaterial_name').hide()
      $("#btnResetRawmaterial").hide()

      // increamental search
      let preFunc = null;
          preInput = '';
          input = '';

      ajaxSearch = function(){
        $.ajax({
          type: 'GET',
          url: '/managers/foodstuffs/search_rawmaterial',
          data: { keyword: input },
          datatype: 'json'
        })
      }

      // search rawmaterial
      $("#search_rawmaterial").on("keyup", function(){
        input = $.trim($("#search_rawmaterial").val());
        if(preInput !== input){
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
        let rawmaterial_id = parseInt((this.id).replace("rawmaterial_", ""))
        // rawmaterial_idを代入
        console.log(this.textContent)
        $('#foodstuff_rawmaterial_id').val(rawmaterial_id)
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
        $('#foodstuff_rawmaterial_id').val("")
        // 検索フォームをクリアする
        $('#search_rawmaterial').val("")
        // 数量フォームの単位をクリア
        $('.input-group-text').text("")
        // 検索フォームを表示する
        $('#search_rawmaterial').show()
        // 非表示する
        $('#choiced_rawmaterial').hide()
        $("#btnResetRawmaterial").hide()
      })
      break;
    default:
      console.log("not passed");
      break;
  }
});
