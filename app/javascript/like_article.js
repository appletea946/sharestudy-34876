function like_article(){
  const article_like = document.getElementById("article-like")
  const article_not_like = document.getElementById("article-not-like");

  function common_part () {
    const form = document.getElementById("article-form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    const article_id = document.getElementById("like_article_article_id").value;
    return {form, formData, XHR, article_id};
  };

  function article_like_ajax () {
    const {form, formData, XHR, article_id} = common_part();
    XHR.open("POST", `/articles/${article_id}/like_articles`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const article_show_content = document.getElementById("article-show-content");
      const item = XHR.response.like;
      const html = `<form id="article-form" action="/articles/${item.article_id}/like_articles/${item.user_id}" accept-charset="UTF-8" method="post"><input type="hidden" name="_method" value="delete"><input type="hidden" name="authenticity_token" value="JacW5UVoDOqgUJLNmS3K49U3hDuPwPocISTBDRNIg7GNeXIVTrevC5m3cL+a8EoXDTO6sW8Nr/OwSxTkROBPyg==">
      <input type="submit" name="commit" value="お気に入り解除" id="article-not-like" class="article-like-btn" data-disable-with="お気に入り解除">
      <input value="${item.user_id}" type="hidden" name="like_article[user_id]" id="like_article_user_id">
      <input value="${item.article_id}" type="hidden" name="like_article[article_id]" id="like_article_article_id">
      </form>
      `;
      article_show_content.insertAdjacentHTML("beforeend",html);
      form.remove();
      const article_not_like = document.getElementById("article-not-like");
      article_not_like.addEventListener("click", (e) => {
        e.preventDefault();
        article_not_like_ajax();
      });
      const like_count = document.getElementById("article-like-count");
      like_count.innerText = Number(like_count.innerText) + 1;
    }
  };

  function article_not_like_ajax(){
    const {form, formData, XHR, article_id} = common_part();
    const like_article_user_id = document.getElementById("like_article_user_id").value;
    XHR.open("DELETE", `/articles/${article_id}/like_articles/${like_article_user_id}`, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      const article_show_content = document.getElementById("article-show-content");
      const item = XHR.response.like;
      const html = `<form id="article-form" action="/articles/${article_id}/like_articles" accept-charset="UTF-8" method="post"><input type="hidden" name="authenticity_token" value="Iy/pGJ23lYJV+mOwHeXzHmI1CKcIURCmvPzk6Bfb7W6L8Y3olmg2Y2wdgcIeOHPqujE2LeicRUktkzEBQHMhFQ==">
      <input type="submit" name="commit" value="お気に入り登録" id="article-like" class="article-like-btn" data-disable-with="お気に入り登録">
      <input value="${like_article_user_id}" type="hidden" name="like_article[user_id]" id="like_article_user_id">
      <input value="${article_id}" type="hidden" name="like_article[article_id]" id="like_article_article_id">
      </form>
      `;
      article_show_content.insertAdjacentHTML("beforeend",html);
      form.remove();
      const article_like = document.getElementById("article-like");
      article_like.addEventListener("click", (e) => {
        e.preventDefault();
        article_like_ajax();
      });
      const like_count = document.getElementById("article-like-count");
      like_count.innerText = Number(like_count.innerText) - 1;
    }
  }


  if (article_like) {
    article_like.addEventListener("click", (e) => {
      e.preventDefault();
      article_like_ajax();
    })
  }

  if (article_not_like){
    article_not_like.addEventListener("click", (e) => {
      e.preventDefault();
      article_not_like_ajax();
    });
  }
}

window.addEventListener("load", like_article);
