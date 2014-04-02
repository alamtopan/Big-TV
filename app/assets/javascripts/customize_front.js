

$(document).ready(function(){
  
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
 $(function(){
    window.prettyPrint && prettyPrint();
    $('#dpYears').datepicker();
  });


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
    $('html,body').animate({scrollTop: $("#channel").offset().top},'slow');
    $(this).addClass('hide');
    return false;
  });

  if($("#sequence").length){
    var options = {
        autoPlay: true
    }
    var sequence = $("#sequence").sequence(options).data("sequence");
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
    // console.log(loc_new)
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
 
  function initilizeLocation(){
    $.each($("#lokasi div.trial"), function( index, div ) {
      if ($(div).hasClass('hide')) {
        $(div).removeClass('hide');
        // $(div).show();
      }; 
      var val = $(this).data('value');
      if(val){
        $.each($("."+val), function( n, locat ) {
          if(n < 12 && $(locat).hasClass('hide')){
            $(locat).removeClass('hide');
            // $(locat).show();
          }else{
            $(locat).addClass('hide');
          }
        });
        $(div).on('click',function(){
          $("."+val).removeClass('hide');
          // $("."+val).show();
          $(this).addClass('hide');
        })
      }
    })
  }

// SEARCH LOCATION BY PROVINCE
if($(".map_location_js").length){
  var firstTimeLocation = true;
  $(".js_button_map").on('click',function(){
    var province = $(this).data('value');
    var province_selector = ".map_location_js[data-province='" + province+ "']";
    $(".js_button_map").removeClass('active');
    $(this).addClass('active');
    $(".map_location_js").closest('tr').addClass('hide');
    var founds = {}

    $.each($("#lokasi div.trial"), function( index, div ) {
      var val = $(div).data('value');
      $(div).addClass('hide');
      founds[val] = 0;

      if(val){

        $.each($("."+val), function( n, locat ) {
          if($(locat).find(province_selector).length){
            if(firstTimeLocation){
              $(div).removeClass('hide');
              $(locat).show();
              $(locat).addClass('hide');
            }else{

              if(founds[val] < 12){
                $(locat).removeClass('hide');
                $(locat).show();
              }else{
                $(div).removeClass('hide');
                $(locat).show();
                $(locat).addClass('hide');
              }
            
            }

            founds[val] += 1;
            
          }else{
            $(locat).removeClass('hide');
            $(locat).hide();
          }
        });
        
      }
    })
    
    // restore();
    // $("#map_section").gmap3({map:{options:{scrollwheel: false}}});
    return false;
  });
}

if($("#lokasi div.trial").length){
  initilizeLocation();
}

// SEARCH LOCATION BY KEYWORD
if($("#search_location").length){
  $("#search_location").on("change",function(){
    if($("#search_location").val().length > 0){
      $(".js_button_map").removeClass('active');
      $(".map_location_js").closest('tr').addClass('hide');
      var regexp = new RegExp($(this).val(), 'i');
      var founds = {}

      $.each($("#lokasi div.trial"), function( index, div ) {
        var val = $(div).data('value');
        $(div).addClass('hide');
        founds[val] = 0;

        if(val){
          $.each($("."+val), function( n, locat ) {
            var loc_data = $(locat).find('.map_location_js').data('value');
            if(loc_data){
              if(String(loc_data.name).match(regexp) || String(loc_data.address).match(regexp)){ 
                if(founds[val] < 12){
                  $(locat).removeClass('hide');
                  $(locat).show();
                }else{
                  $(div).removeClass('hide');
                  $(locat).show();
                  $(locat).addClass('hide');
                }

                founds[val] += 1;
              }else{
                $(locat).removeClass('hide');
                $(locat).hide();
              }
            }else{
              $(locat).removeClass('hide');
              $(locat).hide();
            }
          });
        }
      })

      return false;
    }else{
      // initilizeLocation();
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

  $('.block-twitter-block .content').bind('DOMSubtreeModified',function(){
    var selectors = '.thm-dark, .thm-dark .p-author .profile .p-name,' + 
                    '.thm-dark .cards-base p, .thm-dark .cards-base p a,' + 
                    '.thm-dark .timeline-header .summary,' + 
                    '.thm-dark .byline, .thm-dark .custom-timeline-owner-profile .p-name:focus, ' +
                    '.p-name, .thm-dark .p-author a.profile:focus .p-name, ' +
                    '.customisable-highlight, .p-nickname, .expand, .reply-action, .dt-updated'
                    

    var twitter_iframe = $('.block-twitter-block .content').find('iframe').first().contents();
    twitter_iframe.find(selectors).css('color','#fff');
    twitter_iframe.find('.thm-dark .tweet-box-button').
      css('color', '#000').
      css('background', '#fff');
  });
   
  // $('.fb_widget_block').bind('DOMSubtreeModified',function(){
  //   var fb_iframe = $('.fb_widget_block').find('iframe').first().contents();
  //   fb_iframe.find('.pluginConnectTextDark').css('color','#fff');
  // }); 

})
