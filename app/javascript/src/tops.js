import Swiper from 'swiper';

$(function () {
  let action_name = $('body').data('action')
  console.log(action_name)
  switch (action_name) {
    case "index":
      var elSwiper = document.querySelectorAll('.js-swiper')
      var elBtnPrevSwiper = document.querySelectorAll('.js-swiper-button-prev')
      var elBtnNextvSwiper = document.querySelectorAll('.js-swiper-button-next')
      if (elSwiper.length > 0) {
        for (let i = 0; i < elSwiper.length; i++) {
          elSwiper[i].className += i;
          elBtnPrevSwiper[i].className += i;
          elBtnNextvSwiper[i].className += i;
          var swiper = new Swiper('.js-swiper' + i, {
            loop: true,
            loopFillGroupWithBlank: true,
            navigation: {
              nextEl: '.js-swiper-button-next' + i,
              prevEl: '.js-swiper-button-prev' + i,
            },
            breakpoints: {
              0: {
                slidesPerView: 2,
                slidesPerGroup: 2,
              },
              767: {
                slidesPerView: 4,
                slidesPerGroup: 4
              }
            }
          })
        }
      }
      break;
    case "new":
      break;
    default:
      break;
  }
  const userTabHeight = $("#tab-1").outerHeight()
  $("#tab-2").outerHeight(userTabHeight)

  $("#user-tab").css("font-weight", "bold");

  $("#admin-tab").click(function () {
    $("#admin-tab").css("font-weight", "bold");
    $("#user-tab").css("font-weight", "normal");
  })

  $("#user-tab").click(function () {
    $("#user-tab").css("font-weight", "bold");
    $("#admin-tab").css("font-weight", "normal");
  })

});
