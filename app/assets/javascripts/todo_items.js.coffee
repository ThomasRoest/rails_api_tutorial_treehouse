toggleTodoListFunctions = ->
  $('.todo-list-title').on 'click', (event) ->
    event.preventDefault()
    $functions = $('#todo-list-functions')
    if $functions.is(":hidden")
      $('.todo-list-title span').removeClass('fa-caret-down').addClass('fa-caret-up')
      return $functions.slideDown('fast')
    if $functions.is(":visible")
      $('.todo-list-title span').removeClass('fa-caret-up').addClass('fa-caret-down')
      return $functions.slideUp('fast')
      

$(document).ready toggleTodoListFunctions
$(document).on 'page:load', toggleTodoListFunctions