$(function(){
  var bugs = $("#flot-pie").attr("data-bugs");
  var user_stories = $("#flot-pie").attr("data-user-stories");
  var improvements = $("#flot-pie").attr("data-improvements");
  // pie
  var da = [
    {
      label: "User Stories",
      data: user_stories
    },
    {
      label: "Bugs",
      data: bugs
    },
    {
      label: "Improvements",
      data: improvements
    }
  ],
  series = Math.floor(Math.random() * 4) + 3;

  $("#flot-pie").length && $.plot($("#flot-pie"), da, {
    series: {
      pie: {
        show: true
      }
    },
    colors: ["#545ca6","#6a71b4","#858bc1"],
    legend: {
      show: false
    },
    grid: {
        hoverable: true,
        clickable: false
    }
  });

});
