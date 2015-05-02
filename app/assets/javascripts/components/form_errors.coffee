TimeTracker.FormErrors =

  setErrorsCallback: (prefix) ->
    $(document).bind 'ajax:error', "[id^=#{prefix}_worktime]", (event, jqxhr, settings, exception) =>
      @reRenderForm.call $(event.data), $.parseJSON jqxhr.responseText

  reRenderForm: (response) ->
    if @attr('id').indexOf(response.action) == 0
      @html response.content

  init: (prefix) -> @setErrorsCallback prefix