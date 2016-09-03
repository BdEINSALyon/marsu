$ ->
  $('.send-on-type').keyup( ->
    $(this).closest('form').submit();
  )