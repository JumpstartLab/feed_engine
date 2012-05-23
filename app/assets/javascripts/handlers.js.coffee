jQuery ->
  addSubmitHandlers()
  addServicesHandler()
  integrationsHandler()

integrationsHandler = ->
    $("#github_false").click ->
      setFlash("Added your github account")
    $("#github_true").click ->
      setFlash("Removed your github account")  
    $("#twitter_false").click ->
      setFlash("Added your twitter account")
    $("#twitter_true").click ->
      setFlash("Removed your twitter account") 
    $("#instagram_false").click ->
      setFlash("Added your instagram account")
    $("#instagram_true").click ->
      setFlash("Removed your instgram account") 

addServicesHandler = ->
  $('#services').click ->
    $.getJSON('/authentications', (response, status, jqxhr) ->
      providers = response['providers']
      for provider in providers
        $("##{provider[0]}_false").hide()
        $("##{provider[0]}_true").attr("href","/authentications/#{provider[1]}").show()
    )
    pageSwap("#services-page")

addSubmitHandlers = ->
  $(".errors").hide()
  $(".post-form form .post-button").click ->
    $(".errors").hide()
    $("#image_preview").hide()
    $.feedengine.form = form = $(this).closest('form')
    formData = form.serialize()
    $.ajax(
      type: "POST",
      url: "/posts",
      data: formData
      success: ->
        setFlash('Posted successfully')
        $.feedengine.form.clearForm()
        $("#feed").children().remove()
        new FeedPager($('#feed'))
      error: (response, status) ->
        resp = $.parseJSON(response.responseText)
        errors = $("##{$.feedengine.activeTabId.toLowerCase()}-tab .errors")
        errors.show()
        $(".errors_list").html(null)
        for error in resp["errors"]
          $(".errors_list").append "<li>#{error}</li>"
    )