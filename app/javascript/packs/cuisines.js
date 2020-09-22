$(document).ready(function () {
  console.log($("#tab-foodstuff"))
  $("#tab-foodstuff").css("font-weight", "bold");

  // const tabsArea = document.getElementById('foodstuff-and-procedure')
  // const tabs = tabsArea.getElementsByClassName('nav-link')
  // $('#fp-tab a').on('click', function (e) {
  //   tabs.css("font-weight", "normal");
  //   console.log(e)
  //   console.log(this)
  //   $(this).css("font-weight", "bold");
  //   // $(this).tab('show')
  //   // console.log($(this))
  // })

  // FIXME: タブ切り替え時に
  //           アクティブなときはfont-weightをboldに
  //           非アクティブなときはfont-weightをnormalにしたい
  //        が、下記のイベントが発火してくれない
  // https://getbootstrap.com/docs/4.5/components/navs/　の一番下のコード
  // https://stackoverflow.com/questions/30468111/bootstrap-shown-bs-tab-event-not-working
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    console.log(e)
    console.log(e.target) // newly activated tab
    console.log(e.relatedTarget) // previous active tab
  })
});

console.log("loaded in app/assets/javascripts/users/cuisines.js")
