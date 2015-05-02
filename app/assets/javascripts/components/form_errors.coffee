TimeTracker.FormErrors =

  setErrorsCallback: (prefix) ->
    $("[id^=#{prefix}_worktime]").bind 'ajax:error', (event, jqxhr, settings, exception) =>
      @renderFormErrors.call $(event.data), $.parseJSON jqxhr.responseText

  renderFormErrors: (errors) ->
    TimeTracker.FormErrors.clearErrors.apply @
    $.each errors, (field, messages) ->
      $input = $ "input[name='worktime[#{field}]']"
      $input.closest('.form-group').addClass('has-error').find('.help-block').html messages.join ' & '

  clearErrors: ->
    $('.form-group.has-error', this).each ->
      $('.help-block', $(this)).html ''
      $(this).removeClass 'has-error'

  init: (prefix) ->
    @setErrorsCallback prefix