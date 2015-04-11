'use strict'

$ ->

  $('.worktime-page').on 'click', '#day-record-btn', ->
    $('#day-record-form').modal 'show'

  $('.worktime-page #day-records').on 'ajax:success', '.day-row a.destroy', (event, data, status, xhr) ->
    $(event.target).parent().fadeOut 'fast', ->
      $(this).remove()