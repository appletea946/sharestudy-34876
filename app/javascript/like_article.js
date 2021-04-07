function like_article(){
  const article_like = document.getElementById("article-like");
  const article_not_like = document.getElementById("article-not-like");

  article_like.addEventListener("click", (e) => {
    e.preventDefault();
    const form = document.getElementById("article-form");
    const formData = new FormData(form);
    const XHR = new XMLHttpRequest();
    const article_id = document.getElementById("like_article_article_id").value;
    XHR.open("POST", `/articles/${article_id}/like_articles`, true);
    XHR.responseType = "json";
    XHR.send(formData);
  })

  article_not_like.addEventListener("click", (e) => {
    e.preventDefault();
  })
}

window.addEventListener("load", like_article);
