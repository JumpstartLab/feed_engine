$(function() {
  $("#posts").show();
  $("#privacy").hide();
  $("#services").hide();
  $("#subscriptions").hide();
  $("#account").hide();
  show_div_for_error();
  show_sidebar_for_error();
});
function show_div_for_error() {
  var error_class = $("#error_explanation h2").attr("class");
  if (error_class != null) {
    $("#add_" + error_class).click();
  }
}
function show_sidebar_for_error() {
  var label_text = $("#.field_with_errors label").text();
  if (label_text == "Password") {
    $("#account_id").click();
  }
}
$("#posts_id").live('click', function() {
  $("#posts").show();
  $("#account").hide();
  $("#privacy").hide();
  $("#services").hide();
  $("#subscriptions").hide();
});
$("#privacy_id").live('click', function() {
  $("#privacy").show();
  $("#posts").hide();
  $("#services").hide();
  $("#subscriptions").hide();
  $("#account").hide();
});
$("#services_id").live('click', function() {
  $("#services").show();
  $("#posts").hide();
  $("#privacy").hide();
  $("#subscriptions").hide();
  $("#account").hide();
});
$("#subscriptions_id").live('click', function() {
  $("#subscriptions").show();
  $("#posts").hide();
  $("#privacy").hide();
  $("#services").hide();
  $("#account").hide();
});
$("#account_id").live('click', function() {
  $("#account").show();
  $("#posts").hide();
  $("#privacy").hide();
  $("#services").hide();
  $("#subscriptions").hide();
});
$(function(){
  var sidebar=$('#sidebar');
  sidebar.delegate('a', 'click',function(){
    sidebar.find('.active').toggleClass('active inactive');
    $(this).toggleClass('active inactive');
  });
});
function make_active(post) {
  var posts=$('#posts');
  posts.find('.active').toggleClass('active inactive');
  $(post).toggleClass('inactive active');
}