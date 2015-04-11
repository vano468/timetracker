#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require bootstrap
#= require_self
#= require_tree ./pages

@TimeTracker = {}

$ ->

  do TimeTracker.WorkTimes.init
  TimeTracker.WorkTimes.Modals.click 'new'
  TimeTracker.WorkTimes.FormErrors.init 'new'