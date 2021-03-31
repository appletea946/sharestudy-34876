$(function(){
  const articles = $(".slide>.article");
  const slideSet = $(".slide-set")
  $(".slide-set").text("")
  check = 0
  let div
  for( let i = 0; i < articles.length; i++ ){
    if (i % 12 == 0){
      check ++;
      div = $(`<div></div>`,{
        "class": "articles slide",
        "id": `slide${check}`
      });
    };
    div.append(articles[i])
    if (i % 12 == 11 || i == articles.length - 1){
      slideSet.append(div)
    }
  };

  const slideWidth = $(".slide").outerWidth();
  const slideNum = $(".slide").length;
  const slideSetWidth = slideWidth * slideNum;
  $(".slide-set").css("width", slideSetWidth);

  let count = 0

  $("#prev-btn").on("click", function(){
    count--;
    if(count < 0){
      count = 0;
    }
    
    $(".slide-set").animate({
      left: -slideWidth * count
    });
  });

  $("#next-btn").on("click", function(){
    count++;
    if(count >= slideNum){
      count = slideNum - 1;
    }
    
    $(".slide-set").animate({
      left: -slideWidth * count
    });
  });


})