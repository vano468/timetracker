'use strict'

TimeTracker.WorkTimes =
  setDestroyCallback: ->
    $('.worktime-page #day-records').on 'ajax:success', '.day-row a.destroy', (event, data, status, xhr) ->
      $(event.target).parent().parent().fadeOut 'fast', ->
        $(this).remove()
  init: ->
    do @setDestroyCallback

$ ->
  do TimeTracker.WorkTimes.init
  TimeTracker.Modals.onClick 'new-record'
  TimeTracker.FormErrors.init 'new'