$ ->
  waiters = {}
  refresh = ->
    $this = $(this)
    if(waiters[this] != null)
      clearTimeout waiters[this]
    waiters[this] = setTimeout(()->
      $this.closest('form').submit();
      $("#fetching").show();
    , 500)
  $('.send-on-type').keyup(refresh)
  $('.send-on-type').change(refresh)

  $( "select.s2" ).select2({
    theme: "bootstrap"
  });