# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ -> 
  if $('p.form_field_error').length == 0
    $('#submit_tabs a:first').tab('show')
    $('#dashboard-settings-tabs a:first').tab('show')
  else
    $('#submit_tabs a:first').tab('show')
    $('#dashboard-settings-tabs a[href="#account"]').tab('show')
