# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#document.write(localStorage.getItem("name")); //Hello World!

      #url = '/?page='+localStorage.getItem("nextPage")
      #newNextPage = localStorage.getItem("nextPage") + 1
      #localStorage.setItem("nextPage", newNextPage)

waiting = false

jQuery ->
  localStorage.setItem("nextPage", 2)
  $(window).scroll ->
    url = $('.pagination .next_page a').attr('href')
    if $(window).scrollTop() > $(document).height() - $(window).height() - 25
      if url? && !waiting
        waiting = true
        #alert url
        $.getScript(url, (data, textStatus, jqxhr) ->
          waiting = false)
  $(window).scroll
