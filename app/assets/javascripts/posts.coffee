$(document).on 'turbolinks:load', ->
  $('#add-more-product').on 'ajax:success', (event, data) -> 
    $('#products').append data
    $('#add-more-product').data('params', {'index': $('.product').length })
    

  $(document).on 'click', '.remove-product', (e)->
    $(this).prev('input[type=hidden]').val('true')
    $(this).closest('.product').hide()
    e.preventDefault()