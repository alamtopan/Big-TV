//= require front/js/jquery-1.9.1
//= require jquery_ujs
//= require front/js/jquery-migrate-1.2.1.min
//= require front/js/jquery-ui
//= require front/js/jQuery.easing.min
//= require front/js/jQuery.Opie.PortfolioGallery.min
//= require front/js/classie
//= require front/js/modernizr.custom
//= require front/js/jquery.sequence-min
//= require front/js/jquery.slider.min
//= require front/js/cbpScroller
//= require front/js/niceScroll
//= require front/js/jquery.counters.min
//= require front/js/hover
//= require js/imagesloaded
//= require front/js/init
//= require plugins/bootstrap/js/bootstrap.min
//= require plugins/bootstrap-datepicker/js/bootstrap-datepicker

//= require customize_front
//= require map/gmap3.min
//= require scrolltofixed-min
//= require jquery.lazyload

//= require_self

$(function() {
  $("img").lazyload({
    effect : "fadeIn"
  });
});

$(document).ready(function(){
  $.each($(".side_table_right"),function( index, value ){
    var color = $(value).data('color');
    var hg = $(value).height();
    var total_hg = hg - 50;
    $(value).parent('.parrent_table').find(".head_pack").attr("style","min-height: "+total_hg+"px;background:"+color+"");
  })

  // $('table.grd_masonry_location').filterTable();
  var isImageLoaded = function(img){
    if (!img.complete) { return false; }
    if (typeof img.naturalWidth != "undefined" && img.naturalWidth == 0) {
      return false
    }
    return false;
  }
  

  var resizeImage = function(){
    $(window).resize(function(){
      var imgheight = $('.info img').height();
      $('.cont, .slide-main, .wraper2 , #sequence').css('height', imgheight+'px');

      var imgheight = $('.info img').height();
      $('.cont, .slide-main, .wraper2 , #sequence').css('height', imgheight+'px');
    }).resize();
  }

  jQuery('#nav').scrollToFixed({ marginTop: 0});
 
  
  $('#sequence .info').each(function(){
    if(!isImageLoaded($(this).find('img')[0])){
     $(this).imagesLoaded(function(img){
       resizeImage();
       if($('.bg-raw').css('display') == 'none'){
         $('.bg-raw').show();
         resizeImage();
       }
     });
    }else{
      if($('.bg-raw').css('display') == 'none'){
        $('.bg-raw').show();
        resizeImage();
      }
    }
  });

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

  $("#map_section").gmap3({map:{options:{scrollwheel: false}}});

  // $(window).scroll(function(){
  //   if($(window).scrollTop() > $('.table-responsive .head_pack:first').offset().top){
  //    $('.table-responsive .head_pack').show();
  //     $('.table-responsive .head_pack').css('position','fixed').css('top','0');
  //   } else if($(window).scrollTop() > 3024) {
  //    $('.table-responsive .head_pack').fadeOut();
  //     $('.table-responsive .head_pack').css('position','block');
  //     $('#navigation').css('position','static');
  //   }    
  // });
  //$(window).on('resize', function(){
  // $.each($('.info img'), function(){
  //  $.image = $(this)
  //  console.log($.image)
  //  $.image.on('load', function(){
  //    console.log(imgHeight)
  //        var imgHeight = $(this).height();

  //    $('.cont, .slide-main, .wraper2 , #sequence').css('height',  imgHeight +'px');
  //    var hdHeight = $('.wraper.head').height();
  //    $('.head_bander').css('height', hdHeight+'px');
  //  })
  // })

  //  }).resize();
});
