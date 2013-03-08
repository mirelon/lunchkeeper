# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.quick-add-button').click ->
    $.post $(@).attr('href') + ".json",
      dataType: 'json'
      preselected_id: $(@).attr('preselected_id')
      (data) ->
        location.href = data["location"]