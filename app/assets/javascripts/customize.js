$(document).ready(function(){
  $('li a').on('click',function(){
    $('li').removeClass('active');
    $(this).closest('li').addClass('active');
  })
  // date picker
  $(function(){
    window.prettyPrint && prettyPrint();
    $('#dpYears').datepicker();
  });

  $('.colorpicker').colorpicker();

  // select group id if all select unit
  // $.each($('input.checkbox_item'),function(index,value){
  //   var index = $(value).data('index');
  //   if ($('.unit_item_id_'+index+':checked').length == $('.unit_item_id_'+index).length) { 
  //     $(value).attr('checked','checked');
  //   };
  // })

  // select deselect all in unit item membership
  $('input.checkbox_item').on('click', function(){
    var index = $(this).data('index');
    var child_checkbox = $('.unit_item_id_'+index);
    if(this.checked){
      $(child_checkbox).removeAttr('checked');
      child_checkbox.click();
    }else{
      $(child_checkbox).removeAttr('checked');
    }
  })

})