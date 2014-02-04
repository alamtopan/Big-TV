// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require js/jquery.min
//= require jquery_ujs
//= require plugins/jquery-ui/jquery-ui-1.10.2.custom.min
//= require plugins/bootstrap/js/bootstrap.min
//= require plugins/blockUI/jquery.blockUI
//= require plugins/iCheck/jquery.icheck.min
//= require plugins/perfect-scrollbar/src/jquery.mousewheel
//= require plugins/perfect-scrollbar/src/perfect-scrollbar
//= require js/main
//= require plugins/flot/jquery.flot
//= require plugins/flot/jquery.flot.pie
//= require plugins/flot/jquery.flot.resize.min
//= require plugins/jquery.sparkline/jquery.sparkline
//= require plugins/jquery-easy-pie-chart/jquery.easy-pie-chart
//= require plugins/jquery-ui-touch-punch/jquery.ui.touch-punch.min
//= require plugins/jquery.autocomplete.min
//= require cocoon
//= require plugins/fullcalendar/fullcalendar/fullcalendar

//= require plugins/jquery-inputlimiter/jquery.inputlimiter.1.3.1.min
//= require plugins/autosize/jquery.autosize.min
//= require plugins/select2/select2.min
//= require plugins/jquery.maskedinput/src/jquery.maskedinput
//= require plugins/bootstrap-datepicker/js/bootstrap-datepicker
//= require plugins/bootstrap-timepicker/js/bootstrap-timepicker.min
//= require plugins/bootstrap-daterangepicker/moment.min
//= require plugins/bootstrap-daterangepicker/daterangepicker
//= require plugins/bootstrap-colorpicker/js/bootstrap-colorpicker
//= require plugins/bootstrap-colorpicker/js/commits
//= require plugins/jQuery-Tags-Input/jquery.tagsinput
//= require plugins/bootstrap-fileupload/bootstrap-fileupload.min
//= require plugins/summernote/build/summernote.min
//= require plugins/ckeditor/ckeditor
//= require plugins/ckeditor/adapters/jquery
//= require js/form-elements
//= require front/js/provinces
//= require js/index
//= require customize
//= require plugins/bootstrap-datepicker/bootstrap-datepicker_new

jQuery(document).ready(function() {
 Main.init();
 FormElements.init();
});

Number.prototype.formatMoney = function(c, d, t){
  var n = this, 
  c = isNaN(c = Math.abs(c)) ? 2 : c, 
  d = d == undefined ? "." : d, 
  t = t == undefined ? "," : t, 
  s = n < 0 ? "-" : "", 
  i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", 
  j = (j = i.length) > 3 ? j % 3 : 0;
 return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};



$(document).ready(function(){
  $.each($(".side_table_right"),function( index, value ){
    var color = $(value).data('color');
    var _parent = $(value).parents('.parrent_table').first();
    _parent.find(".head_pack").attr("style","background:"+color+"");
  });
});

$(document).ready(function(){
  var decoders = $('.pck_decode_table');
  var decoder_price = Number($(decoders[0]).attr('data-price'));
  var total_decoder = 1;

  $('.pck_decode_table').on('click',function(){
    
    
    total_decoder = decoders.index($(this)) + 1;
    if(total_decoder > 1 && upgrade_packages.indexOf(current_package_name) < 0){
      $('.upgrade-package-cont').show();
      $('html, body').animate({
          scrollTop: $('.upgrade-package-cont').offset().top
      }, 2000);
    }else{
      $('.pck_decode_table').removeClass('pck_decode_table_active');
      $('.pck_decode_table:lt('+total_decoder+')').addClass('pck_decode_table_active');
      $('.membership-id-field').val($(this).attr('data-index'));

      // decoder_price = Number($(decoders[0]).attr('data-price'));
      // for (var z = 1; z < total_decoder; z++) {
      //   decoder_price += Number($(decoders[z]).attr('data-price'));
      // }
      if($(this).hasClass('selected')){
        console.log('has selected')
      }else{
        $('.pck_decode_table').removeClass('selected')
        $.get('/extra.js?extra_id='+$(this).attr('data-index')+'&add=true')
        $(this).addClass('selected')
      }
    }
    
  })

  $('form.form-subscribe').on('ajax:beforeSend', function(evt, xhr, settings){
    $.submit_btn = $('form.form-subscribe input[type="submit"]');
    $.submit_btn.val('HARAP TUNGGU');
    $.submit_btn.attr('disabled', 'disabled');
  }).
  on('ajax:error', function(xhr, status, error){
    //location.reload();
  }).
  on('ajax:complete', function(xhr, status){
    $.submit_btn = $('form.form-subscribe input[type="submit"]');
    $.submit_btn.val('LANJUT KE PEMBAYARAN');
    $.submit_btn.removeAttr('disabled');
  })

  $('.cb-referensi').on('change', function(){
    if($(this).val() != 'Others'){
      $('.tf-dealer').show();
    }else{
      $('.tf-dealer').hide();
    }
  });

  $('input[name="membership_ids[]"]').on('change', function(){
    $.get('/extra.js?extra_id='+$(this).val()+'&add='+$(this).is(':checked'))
  });

  function calculateTotalSubscription(){
    var total = Number($('#total-nominal').data('value'));
    var fee = 0;
    
    // if(String($('input[name="customer[profile_attributes][billing_method]"]:checked').val()) == 'post'){
    //   total = total + 7500;
    //   $('.post_fee').removeClass('hide')
    // }else{
    //   $('.post_fee').addClass('hide')
    // }

    var new_total = Number($('#mm').val()) * total;

    // if(String($('input[name="payment_method"]:checked').val()) == '01'){
    //   fee = new_total*(3.5/100);
    //   $('.install_fee').removeClass('hide');
    // }else 
    if(String($('input[name="payment_method"]:checked').val()) == '04'){
      fee = new_total*(2.0/100);
      $('.install_fee').removeClass('hide');
    }else{
      $('.install_fee').addClass('hide');
    }

    new_total = new_total + fee; 
    $('.install_fee_nominal').html(fee.formatMoney(0,'.',','))
    var new_total_str = new_total.formatMoney(0,'.',',');
    $('#total-nominal').html(new_total_str);
    $('#hidden_total').val(new_total);
  }

  $('#mm').on('change', function(){
    calculateTotalSubscription();
  });

  if($('#mm').length && Number($('#mm').data('period')) > 0){
    $('#mm').val(Number($('#mm').data('period')));
    calculateTotalSubscription();
  }

  $('input[name="payment_method"]').on('change',function(){
    if($(this).val() == 'lokasi'){
      $('.file-faktur-container').removeClass('hide');
      $('#file_faktur').attr('required','required');
    }else{
      $('.file-faktur-container').addClass('hide');
      $('#file_faktur').removeAttr('required');
    }
    calculateTotalSubscription();
  });

  $('input[name="customer[profile_attributes][billing_method]"]').on('change', function(){
    calculateTotalSubscription();
  });

  $('#customer_profile_attributes_province').autocomplete({
      data: window.provinces,
      onItemSelect: function(result){

        $('#customer_profile_attributes_city').removeData();
        $('#customer_profile_attributes_city').unbind();
        $('#customer_profile_attributes_city').autocomplete({
          data: window.provinces_cities[result.value]
        })
      }
  });
  $('#customer_profile_attributes_province').focus(function(){
    $('#customer_profile_attributes_city').val('')
  });
});


