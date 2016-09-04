$ ->
  $('.send-on-type').keyup( ->
    $(this).closest('form').submit();
    $("#fetching").show();
  )

  $( "select.s2" ).select2({
    theme: "bootstrap"
  });