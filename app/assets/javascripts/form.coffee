$ ->
  $('.send-on-type').keyup( ->
    $(this).closest('form').submit();
  )

  $( "select.s2" ).select2({
    theme: "bootstrap"
  });