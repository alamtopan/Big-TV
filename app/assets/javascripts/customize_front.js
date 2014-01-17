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
    $('html,body').animate({scrollTop: $("#team").offset().top},'slow');
    $(this).addClass('hide');
    return false;
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
      $(".js_button_map").removeClass('active');
      $(this).addClass('active');
      $(".map_location_js").closest('tr').addClass('hide');
      $(".map_location_js[data-province='" + province+ "']").closest('tr').removeClass('hide');
      $(".map_location_js[data-province='" + province+ "']").removeClass('hide');
      // restore();
      // $("#map_section").gmap3({map:{options:{scrollwheel: false}}});
      return false;
    });
  }

  if($("div.trial").length){
    initilizeLocation();
  }

  function initilizeLocation(){
    $.each($("div.trial"), function( index, div ) {
      var val = $(this).data('value');
      if(val){
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
      }
    })
  }

function restore(){

  $('#map_section').gmap3({
      action: 'destroy'
  });

  var container = $('#map_section').parent();
  $('#map_section').remove();
  container.append('<div id="map_section"></div>');

  // create new gmap
  var isi = [];
  $.each($(".map_location_js:not(.hide)"), function( index, loc_new ) {
    console.log(loc_new)
    var value = $(loc_new).data('value');
    isi.push({latLng: [$(loc_new).data('latitude'),$(loc_new).data('longitude')], data:'<div class="infowindow"><h2>'+value[0].name+'<br/></h2><p> '+value[0].address+' <br/><i> '+value[0].area+' '+value[0].phone+' </i></p></div>', options:{icon: "/assets/map-marker.png"}})
  });
  $("#map_section").gmap3({
    map:{
      options:{
        center: [$(".map_location_js:not(.hide)").first().data('latitude'),$(".map_location_js:not(.hide)").first().data('longitude')],
        zoom: 6,
        scrollwheel: false
      }
    },
    marker:{
      values: isi,
      options:{
        draggable: false
      },
      events:{
        mouseover: function(marker, event, context){
          var map = $(this).gmap3("get"),
            infowindow = $(this).gmap3({get:{name:"infowindow"}});
          if (infowindow){
            infowindow.open(map, marker);
            infowindow.setContent(context.data);
          } else {
            $(this).gmap3({
              infowindow:{
                anchor:marker, 
                options:{content: context.data}
              }
            });
          }
        },
        mouseout: function(){
          var infowindow = $(this).gmap3({get:{name:"infowindow"}});
          if (infowindow){
            infowindow.close();
          }
        }
      }
    }
  });
}

if($("#search_location").length){
  $("#search_location").on("change",function(){
    if($("#search_location").val().length > 0){
      $(".js_button_map").removeClass('active');
      $(".map_location_js").closest('tr').addClass('hide');
      var regexp = new RegExp($(this).val(), 'i');
      var count_hide = 0;
      $(".map_location_js").each(function(index, el){
        if($(el).data('value')){
          if(String($(el).data('value').name).match(regexp) || String($(el).data('value').address).match(regexp)){ 
            $(el).closest('tr').removeClass('hide');
          }
        }
      })
      $("#map div.trial").each(function(index_more, el_more){
        var categoryDiv = $(el_more).data('value');
        if($(".grid_packages_location."+categoryDiv).length == $(".grid_packages_location.hide."+categoryDiv).length){
          $(el_more).addClass('hide');
        }else{
          $(el_more).removeClass('hide');
        }
      });
      return false;
    }else{
      initilizeLocation();
      $('.js_button_map[data-value="Jawa Madura"]').click();
    }
  });
  $('.js_button_map[data-value="Jawa Madura"]').click();
}

  $("input[type='radio'][name='billing']").on('click',function(){
    if($(this).val() == 'post'){
      $("#user_profile_attributes_address_shipping").attr('required',false);
    }else{
      $("#user_profile_attributes_address_shipping").attr('required','required');  
    }

  })

})
