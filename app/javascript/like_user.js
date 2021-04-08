function like_user(){
  const user_like = document.getElementById("user-like")
  const user_not_like = document.getElementById("user-not-like");

  function common_part () {
    const form = document.getElementById("user-form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    const user_id = document.getElementById("like_user_receive_user").value;
    return {form, formData, XHR, user_id};
  };

  function user_like_ajax () {
    const {form, formData, XHR, user_id} = common_part();
    XHR.open("POST", `/users/${user_id}/like_users`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const user_info_name = document.getElementById("user-info-name");
      const token = document.getElementsByName("authenticity_token")[0].value;
      const item = XHR.response.like;
      const html = `<form id="user-form" action="/users/${item.receive_user}/like_users/${item.receive_user}" accept-charset="UTF-8" method="post"><input type="hidden" name="_method" value="delete"><input type="hidden" name="authenticity_token" value="${token}">
      <input type="submit" name="commit" value="お気に入り解除" class="user-like-box" id="user-not-like" data-disable-with="お気に入り解除">
      <input value="${item.give_user}" type="hidden" name="like_user[give_user]" id="like_user_give_user">
      <input value="${item.receive_user}" type="hidden" name="like_user[receive_user]" id="like_user_receive_user">
      </form>
      `;
      user_info_name.insertAdjacentHTML("afterend",html);
      form.remove();
      const user_not_like = document.getElementById("user-not-like");
      user_not_like.addEventListener("click", (e) => {
        e.preventDefault();
        user_not_like_ajax();
      });
      const like_count = document.getElementById("user-like-count");
      like_count.innerText = Number(like_count.innerText) + 1;
    }
  };

  function user_not_like_ajax(){
    const {form, formData, XHR, user_id} = common_part();
    XHR.open("DELETE", `/users/${user_id}/like_users/${user_id}`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const user_info_name = document.getElementById("user-info-name");
      const give_user = document.getElementById("like_user_give_user").value;
      const receive_user = document.getElementById("like_user_receive_user").value;
      const token = document.getElementsByName("authenticity_token")[0].value;
      const html = `<form id="user-form" action="/users/${receive_user}/like_users" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token" value="${token}">
      <input type="submit" name="commit" value="お気に入り登録" class="user-like-box" id="user-like" data-disable-with="お気に入り登録">
      <input value="${give_user}" type="hidden" name="like_user[give_user]" id="like_user_give_user">
      <input value="${receive_user}" type="hidden" name="like_user[receive_user]" id="like_user_receive_user">
      </form>
      `;
      user_info_name.insertAdjacentHTML("afterend",html);
      form.remove();
      const user_like = document.getElementById("user-like");
      user_like.addEventListener("click", (e) => {
        e.preventDefault();
        user_like_ajax();
      });
      const like_count = document.getElementById("user-like-count");
      like_count.innerText = Number(like_count.innerText) - 1;
    }
  }


  if (user_like) {
    user_like.addEventListener("click", (e) => {
      e.preventDefault();
      user_like_ajax();
    })
  }

  if (user_not_like){
    user_not_like.addEventListener("click", (e) => {
      e.preventDefault();
      user_not_like_ajax();
    });
  }
}

window.addEventListener("load", like_user);