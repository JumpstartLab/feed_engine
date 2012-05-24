$ ->
  $("#alert-bar").click -> 
    $(this).stop()
  
  full_path = window.location.host
  full_path_array = full_path.split('.')
  subdomain_length = full_path_array.length
  current_path = window.location.pathname
  if subdomain_length == 2 && current_path == '/dashboard' 
    $('#nav-stream').removeClass("active")
    $('#nav-dashboard').addClass("active")
    $('title').text("troutr dashboard")
  else if subdomain_length == 3 && current_path == "/"
    if $('.current-user').data("display-name") == full_path_array[0]
      $('#nav-stream').addClass("active")
      $('#nav-dashboard').removeClass("active")
      $('title').text("troutr stream")
  else 
    $('#nav-dashboard').removeClass("active")
    $('#nav-stream').removeClass("active")
    $('title').text("troutr river")
