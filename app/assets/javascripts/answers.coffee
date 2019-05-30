ready = ->
  $('a.edit-answer-link').click (e) ->
    e.preventDefault();
    answer_id = $(this).data('answerId');
    $('div#' + answer_id + '.answer > form.edit_answer').show();

$(document).on('turbolinks:load', ready)
