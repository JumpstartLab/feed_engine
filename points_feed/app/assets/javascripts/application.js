// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require twitter/bootstrap
//= require cookies
//= require mustache
//= require timeago
//= require validate
//= require waypoint
//= require typeahead
//= require_tree .

//access_token = $("#access_token").val();

function success_notify(msg) {
  $(".alert-success").html(msg).slideDown('slow').delay(2000).slideUp('slow');
}

function points_notify(el, msg) {
  el.find(".points-success").html(msg).slideDown('slow').delay(2000).slideUp('slow');
}

function error_notify(msg) {
  $(".alert-error").html(msg).slideDown('slow').delay(2000).slideUp('slow');
}

function info_notify(msg) {
  $(".alert-info").html(msg).slideDown('slow').delay(2000).slideUp('slow');
}

function show_loading(div) {
  div.html('<div id="loading" style="width:100%; text-align:center"><img src="assets/loading.gif"></img></div>');
}

function hide_loading(div) {
  div.find('#loading').slideUp('slow').html('');
}

$('.typeahead').typeahead({
  source: function (typeahead, query) {
    $.get("/api/users/", { "q": query }, function(data) {
      typeahead.process(data);
    });
  },

  property: "name",

  onselect: function (obj) {
    location.href = "http://"+obj.name+".pointsfeed.in";
  }
});

$('.alert').delay(5000).slideUp('slow');