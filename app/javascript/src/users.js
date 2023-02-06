$(function () {
  const action_name = document.body.dataset.action
  const csrfToken = document.getElementsByName('csrf-token')[0].content

  switch (action_name) {
    case "show":
      const file_field = document.getElementById('user-img')
      const user_avatar_image = document.getElementById('user-avatar')
      user_avatar_image.addEventListener('click', function(){
        file_field.click();
      });

      // insert preview of profile_image
      file_field.addEventListener('change', function () {
        if (this.files && this.files[0]) {
          let reader = new FileReader
          reader.onload = function (e) {
            document.getElementById('user-avatar').src = e.target.result
          }
          reader.readAsDataURL(this.files[0])
        }
      })
      break;
    case "new":
    case "create":
    default:
      break;
  }
});
