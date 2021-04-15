function inputSample() {
  const input_sample_btn = document.getElementById("input-sample")
  if (input_sample_btn){
    input_sample_btn.addEventListener("click", function(){
      const title = document.getElementById("article-title");
      const tag = document.getElementById("article-tag");
      const content = document.getElementById("content");
      title.value = "SQLのWHERE句について";
      tag.value = "SQL";
      content.value = `
SQLとは
SQLはデータベース(RDBMS)を操作するための言語です。データベースにデータを挿入したり、検索したりする際に利用します。
  
簡単なSQL文の紹介
・SELECT * FROM テーブル名;
テーブルの中から全てのデータを取り出します。

ここにWHERE句を使って取り出すデータを絞り込むことができます。

・SELECT * FROM テーブル名 WHERE 条件式;
テーブルから条件式に当てはまるデータを全て取得します。

以下usersテーブルがあるとし、id,nickname,age,email,passwordのカラムがあるとします。

年齢が30歳以上のユーザーを取り出してみましょう。
・SELECT * FROM users WHERE age >= 30;

次は年齢が30歳以上で名前(nickname)がaから始まるユーザーを取り出してみましょう。
・SELECT * FROM users WHERE age >= 30 AND nickname LIKE "a%";

ANDはそれの左右にある条件を満たすものを取り出します。LIKEは曖昧検索をしています。
      `
    });

  };
};

window.addEventListener("load", inputSample)