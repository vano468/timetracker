'use strict'

TimeTracker.WorkTimes =

  setDestroyCallback: ->
    $('.worktime-page #day-records').on 'ajax:success', '.day-row a.destroy', (event, data, status, xhr) ->
      $(event.target).parent().fadeOut 'fast', ->
        $(this).remove()

  init: ->
    do @setDestroyCallback


TimeTracker.WorkTimes.Modals =

  open: (action) ->
    self = $ "##{action}-record-modal #day-record-form"
    TimeTracker.WorkTimes.FormErrors.clearErrors.call self
    self.modal 'show'

  hide: (action) ->
    $("##{action}-record-modal #day-record-form").modal 'hide'

  click: (action) ->
    $('.worktime-page').on 'click', "##{action}-record", => @open action


TimeTracker.WorkTimes.FormErrors =

  setErrorsCallback: (prefix) ->
    $(document).bind 'ajaxError', "form##{prefix}_worktime", (event, jqxhr, settings, exception) =>
      @renderFormErrors.call $(event.data), $.parseJSON jqxhr.responseText

  renderFormErrors: (errors) ->
    TimeTracker.WorkTimes.FormErrors.clearErrors.apply @
    $.each errors, (field, messages) ->
      $input = $ "input[name='worktime[#{field}]']"
      $input.closest('.form-group').addClass('has-error').find('.help-block').html messages.join ' & '

  clearErrors: ->
    $('.form-group.has-error', this).each ->
      $('.help-block', $(this)).html ''
      $(this).removeClass 'has-error'

  init: (prefix) ->
    @setErrorsCallback prefix