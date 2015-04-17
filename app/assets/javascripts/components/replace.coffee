'use strict'

TimeTracker.Replace =

  modal: (prefix, content) ->
    $("##{prefix}-modal").empty().append content

  content: (target, content) ->
    setTimeout ->
      $("##{target}").empty().append content
    , 300