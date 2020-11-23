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
    case "edit":
    case "update":
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
        // rawmaterial_idを取得
        let clicked_rawmaterial_id = parseInt((this.id).replace("rawmaterial_", ""))
        $('#foodstuff_rawmaterial_id').val(clicked_rawmaterial_id)
        // 食材名をバッジ内に表示、バッジを表示
        $('#rawmaterial_name').text(this.textContent)
        $('#choiced_rawmaterial').show()
        console.log(this.dataset.unitName === "その他")
        if (this.dataset.unitName === "その他") {
          $('#rawmaterial_measure_unit').hide()
        }else{
          $('.input-group-text').text(this.dataset.unitName)
        }
        $("#search_rawmaterial").hide()
        $('#search_results').hide()
        $('.rawmaterial').hide()
      })

      // reset choiced rawmaterial
      $("#btnResetRawmaterial").on("click", function () {
        $('#rawmaterial_name').text("")
        $('#foodstuff_rawmaterial_id').val("")
        $('#search_rawmaterial').val("")
        $('.input-group-text').text("")
        $('.search_rawmaterial').show()
        $('#search_rawmaterial').show()
        $('#choiced_rawmaterial').hide()
        $('#rawmaterial_measure_unit').show()
      })
      break;
    default:
      //     console.log("not passed");
      break;
  }
});
