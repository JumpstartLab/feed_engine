$ ->
  $("#alert-bar").click -> 
    $(this).stop()
  
  full_path = window.location.host
  subdomain = full_path.split('.')[0]
  current_path = window.location.pathname
  if subdomain == null 
    $('title').text("troutr river")
    $('#nav-stream').removeClass("active")
    $('#nav-dashboard').removeClass("active")
  else if current_path == "/"
    $('#nav-stream').addClass("active")
    $('#nav-dashboard').removeClass("active")
    $('title').text("troutr stream")
  else if current_path == "/dashboard"
    $('#nav-dashboard').addClass("active")
    $('#nav-stream').removeClass("active")
    $('title').text("troutr dashboard")
