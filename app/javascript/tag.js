if (location.pathname.match("articles/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("article-tag");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("article-tag").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `tag_search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.name;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("article-tag").value = clickElement.textContent;
              searchResult.innerHTML = "";
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};