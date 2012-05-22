jQuery ->
  $("#all").click ->
    $(".active").removeClass("active")
    $("#all").addClass("active")
    $.getScript("http://#{domain}")
  $("#images").click ->
    $(".active").removeClass("active")
    $("#images").addClass("active")
    $.getScript("http://#{domain}?type=Image")
  $("#messages").click ->
    $(".active").removeClass("active")
    $("#messages").addClass("active")
    $.getScript("http://#{domain}?type=Message")
  $("#links").click ->
    $(".active").removeClass("active")
    $("#links").addClass("active")
    $.getScript("http://#{domain}?type=Link")
  $("#tweets").click ->
    $(".active").removeClass("active")
    $("#tweets").addClass("active")
    $.getScript("http://#{domain}?type=Tweet")
  $("#github").click ->
    $(".active").removeClass("active")
    $("#github").addClass("active")
    $.getScript("http://#{domain}?type=GithubEvent")
  $("#instagrams").click ->
    $(".active").removeClass("active")
    $("#instagrams").addClass("active")
    $.getScript("http://#{domain}?type=InstagramPhoto")

  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next > a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Fetching more growls...")
        $.getScript(url)
    $(window).scroll
