$(function(){
  $("#minidash").click(function(event) {
    event.preventDefault();
    $("#services_toggle").slideToggle("slow");
  });  
})