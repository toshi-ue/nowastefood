import 'select2';

$(function () {
  let action_name = $('body').data('action');

  const csrfToken = document.querySelector('[name="csrf-token"]').getAttribute('content');

  let h_value_rawmaterial_id

  switch (action_name) {
    //   case "index":
    //     break;
    //   case "show":
    //     break;
    case "new":
      // search rawmaterial
      $(".select_foodstuff").select2({
        ajax: {
          url: '/managers/foodstuffs/search_rawmaterial',
          type: 'GET',
          datatype: 'json',
          delay: 500,
          data: function(params){
            return { q: params.term }
          },
          processResults: function(data, params){
            return{
              results: $.map(data, function(obj){
                return { id: obj.id, text: obj.name };
              })
            };
          }
        },
        theme: 'bootstrap4',
      })

      // search unit_name
      $(".select_foodstuff").on('select2:select', function (e) {
        let rawmaterial_id = e.params.data.id
        $(".input-group-text").text("")
        $.ajax({
          type: 'GET',
          url: '/managers/foodstuffs/search_unit',
          data: { rm_id: rawmaterial_id },
          dataType: 'json'
        }).done(function (data) {
          $(".input-group-text").text(data.name)
        }).fail(function (error) {
          console.log("could not get unit name.")
          console.log(error)
        })
      })

      let radio_buttons_rough_quantities = $('input[name="rough_quantity"]')
      console.log($('input[name="rough_quantity"]'))
      let checked_radio_button = radio_buttons_rough_quantities.filter(':checked').val()
      console.log(checked_radio_button)
      radio_buttons_rough_quantities.on('click', function(){
        if ($(this).val() === checked_radio_button) {
          $(this).prop('checked', false);
          checked_radio_button = '';
          $('#foodstuff_quantity').attr('readonly', false);
          $('#foodstuff_quantity').val('')
        }else{
          $(this).prop('checked', true);
          checked_radio_button = $(this).val();
          $('#foodstuff_quantity').val($(this).val())
          $('#foodstuff_quantity').attr('readonly', true);
        }
      })
      break;
    case "create":
    case "edit":
    case "update":
      // check existence of cuisine_id
      // saveメソッドが失敗した時に実行してほしい
      h_value_rawmaterial_id = $('#foodstuff_rawmaterial_id').val()
      // console.log(h_value_rawmaterial_id)
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
          // console.log(input);
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
        // if (this.dataset.unitName === "その他") {
        const undisplay_unit_names = ["その他"]
        if (undisplay_unit_names.includes(this.dataset.unitName)) {
          $('#rawmaterial_measure_unit').hide()
        }else{
          $('.input-group-text').text(this.dataset.unitName)
          document.getElementById("rawmaterial_measure_unit").style.display = "block"
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
        document.getElementById("rawmaterial_measure_unit").style.display = "none"
      })

      function copyquantity(e){
        const formEl = document.getElementById("foodstuff_quantity")
        if (this.checked) {
          formEl.value = this.value
          formEl.readOnly = true
        }else{
          formEl.readOnly = false
          formEl.value = ""
        }
      }

      const proper = document.getElementById("proper")
      const little = document.getElementById("little")
      const asyoulike = document.getElementById("asyoulike")

      proper.addEventListener("change", copyquantity)
      little.addEventListener("change", copyquantity)
      asyoulike.addEventListener("change", copyquantity)
      break;
    default:
      //     console.log("not passed");
      break;
  }
});
