$ ->
  waiters = {}
  $('.send-on-type').keyup( ->
    $this = $(this)
    if(waiters[this]!=null)
      clearTimeout waiters[this]
    waiters[this] = setTimeout(()->
      $this.closest('form').submit();
      $("#fetching").show();
    , 500)
  )

  $( "select.s2" ).select2({
    theme: "bootstrap"
  });