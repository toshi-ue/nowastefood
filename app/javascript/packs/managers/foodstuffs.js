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
      $("#search_rawmaterial").on("keyup", function(){
        input = $.trim($("#search_rawmaterial").val());
        if(preInput !== input){
          clearTimeout(preFunc);
          setTimeout(ajaxSearch, 1000);
          console.log(input);
        }
        preInput = input;
      })

      // //
      // let rawmaterial_el = doc
      break;
    default:
      console.log("not passed");
      break;
  }
});
