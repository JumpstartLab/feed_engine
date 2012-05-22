$(function(){
  $("#services_link").click(function(event) {
    event.preventDefault();
    $("#services_toggle").slideToggle("slow");
  });  
})