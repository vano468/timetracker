'use strict'

TimeTracker.Modals =

  open: (prefix) ->
    self = $ "##{prefix}-modal .modal"
    #TimeTracker.WorkTimes.FormErrors.clearErrors.call self
    self.modal 'show'

  hide: (prefix) ->
    $("##{prefix}-modal .modal").modal 'hide'

  onClick: (target) ->
    $(document).on 'click', "##{target}", => @open target