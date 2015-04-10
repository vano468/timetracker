#= require jquery
#= require jquery_ujs
#= require bootstrap-sprockets
#= require bootstrap
#= require_self
#= require_tree .

$ ->
  $('body').on 'click', '#day-record-btn', ->
    $('#day-record-form').modal 'show'