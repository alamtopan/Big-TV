$(document).ready(function(){
  $('li a').on('click',function(){
    $('li').removeClass('active');
    $(this).closest('li').addClass('active');
  })
  $('.datepicker').datepicker();
  $('.colorpicker').colorpicker();
})