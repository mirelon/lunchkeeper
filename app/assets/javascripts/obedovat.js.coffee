# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#obedovat_form').submit ->
    json = []
    $(':checked').each ->
      json.push
        code: $(@).parent().find('#code_' + @.id).val()
        description: $(@).parent().find('#description_' + @.id).val()
    $('#json').val(JSON.stringify(json))
