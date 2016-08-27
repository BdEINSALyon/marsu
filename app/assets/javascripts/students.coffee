# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ()->
  $('.has-danger input').addClass('form-control-danger')
  t = null
  $('#students_search').keyup ()->
    value = $('#students_search').val();
    if(t!=null)
      clearTimeout t
    t = setTimeout(()->
      if(value.length>2)
        $('#students_search_form').submit()
        $('#fetching').css('display', 'block')
    , 300)
