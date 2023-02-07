import 'select2';

$(function () {

  // increamental search
  //   search rawmaterial
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

  $(".select_foodstuff").on('select2:select', function (e) {
    //   search unit_name
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

    const toggleTargetDom = $(".ambiguous-value")
    console.log(toggleTargetDom)
    $.ajax({
      type: 'GET',
      url: '/managers/foodstuffs/search_foodcategory',
      data: { rm_id: rawmaterial_id },
      dataType: 'json'
    }).done(function (data) {
      console.log(data)
      console.log(typeof(data))
      if (data == 4) {
        toggleTargetDom.css('visibility', 'hidden')
      }else{
        toggleTargetDom.css('visibility', 'visible')
      }
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
});
