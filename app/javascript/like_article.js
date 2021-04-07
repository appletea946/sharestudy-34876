function like_article(){
  const article_like = document.getElementById("article-like");
  const article_not_like = document.getElementById("article-not-like");

  article_like.addEventListener("click", (e) => {
    e.preventDefault();

  })

  article_not_like.addEventListener("click", (e) => {
    e.preventDefault();
  })
}

window.addEventListener("load", like_article);
