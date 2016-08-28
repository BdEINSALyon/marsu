# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

accentsTidy = (s) ->
  r = s.toLowerCase()
  #	r = r.replace(new RegExp(/\s/g),"");
  r = r.replace(new RegExp(/[àáâãäå]/g), 'a')
  r = r.replace(new RegExp(/æ/g), 'ae')
  r = r.replace(new RegExp(/ç/g), 'c')
  r = r.replace(new RegExp(/[èéêë]/g), 'e')
  r = r.replace(new RegExp(/[ìíîï]/g), 'i')
  r = r.replace(new RegExp(/ñ/g), 'n')
  r = r.replace(new RegExp(/[òóôõö]/g), 'o')
  r = r.replace(new RegExp(/œ/g), 'oe')
  r = r.replace(new RegExp(/[ùúûü]/g), 'u')
  r = r.replace(new RegExp(/[ýÿ]/g), 'y')
  r = r.replace(new RegExp(RegExp(' ', 'g')), '-')
  #	r = r.replace(new RegExp(/\W/g),"");
  r

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
  $("#mail-insa").click ()->
    $form = $(this).closest('form');
    first_name = accentsTidy $form.find('input[name="student[first_name]"]').val()
    last_name = accentsTidy $form.find('input[name="student[last_name]"]').val()
    email = "#{first_name}.#{last_name}@insa-lyon.fr"
    $form.find('input[name="student[email]"]').val(email)
