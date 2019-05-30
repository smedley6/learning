ready = ->
  $('.question > .edit-link').click (e) ->
    e.preventDefault();
    $('.question > .edit_question').show();

$(document).on('turbolinks:load', ready)
