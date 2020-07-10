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

      // get clicked-element
      $("#rawmaterial_5").on("click", function(){
        console.log(this.id)
        console.log(this)
        $(this).attr("id")
      })

      $(".rawmaterial").on("click", function () {
        // 下記の書き方でクリックしたエレメントのidが取れる
        console.log(this.id)
        console.log(this)
        $(this).attr("id")
        let rawmaterial_id = this.id
      })
      break;
    default:
      console.log("not passed");
      break;
  }
});
