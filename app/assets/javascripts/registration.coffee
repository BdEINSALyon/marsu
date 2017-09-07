# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  fromWantToCheque = (product)->
    $('input[name=products]').val(product)
    $('#he-want').addClass('hidden')
    if product == 'VA'
      $('.price').html('95')
    else
      $('.price').html('130')
    $('#cheque').removeClass('hidden')

  $('#he-want-VA').click ()->
    fromWantToCheque 'VA'
  $('#he-want-VA-WEI').click ()->
    fromWantToCheque 'VA-WEI'


  $('#oui-c-est-chiant').click ()->
    $('input[name=kfet]').val('oui')
    $('#he-pay-with').removeClass('hidden')
    $('#he-pay-with .price').html('17')
  $('#non-c-est-bien').click ()->
    $('input[name=kfet]').val('non')
    $('#he-pay-with .price').html('20')
    $('#he-pay-with').removeClass('hidden')

  $('#no-cheque').click ()->
    $('#cheque').addClass('hidden')
    $('#payment').removeClass('hidden')