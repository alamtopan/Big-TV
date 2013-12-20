$(document).ready(function(){
  $('#mm').on('change', function(){
    var total = $('#total-nominal').data('value');
    var new_total = $(this).val() * total;
    var new_total_str = new_total.formatMoney(0,'.',',');
    $('#total-nominal').html(new_total_str);
    $('#hidden_total').val(new_total);
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

 // date picker
 $('.datepicker').datepicker();


 // channel
  var limit = $('#team_members_channel').data('limit');
  $(".channel_member").each(function( index, el ) {
    if (index > (limit - 2)){
      $(el).addClass('hide');
    }
  })
  if($('.channel_member').length < limit){
    $('#view-more-channel').addClass('hide');
  }

  $('#view-more-channel').on('click',function(){
    $('.channel_member').removeClass('hide');
    $(this).addClass('hide');
  });

  if($("#sequence").length){
    var options = {
        autoPlay: true
    }
    var sequence = $("#sequence").sequence(options).data("sequence");
  }

  if($(".map_location_js").length){
    $(".js_button_map").on('click',function(){
      var province = $(this).data('value');
      $(".map_location_js").closest('tr').addClass('hide');
      $(".map_location_js[data-province='" + province+ "']").closest('tr').removeClass('hide');
      return false;
    });
  }

  if($("#search_location").length){
    $("#search_location").on("change",function(){
      $(".map_location_js").closest('tr').addClass('hide');
      $(".map_location_js:contains('"+$(this).val()+"')").closest('tr').removeClass('hide');
      return false;
    });
  }
  if($("div.trial").length){
    $.each($("div.trial"), function( index, div ) {
      var val = $(this).data('value');
      $.each($("."+val), function( n, locat ) {
        if(n < 12){
          if($(locat).hasClass('hide')){
            $(locat).removeClass('hide');
          }
        }else{
          $(locat).addClass('hide');
        }
      });
      $(div).on('click',function(){
        $("."+val).removeClass('hide');
        $(this).addClass('hide');
      })
    })
  }

})