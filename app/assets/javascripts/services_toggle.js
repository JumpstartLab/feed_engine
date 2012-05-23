$(function(){
  $("#sliding_toggle").click(function(event) {
    event.preventDefault();
    $("#services_toggle").slideToggle("slow");
  });  
})