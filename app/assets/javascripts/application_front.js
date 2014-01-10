//= require front/js/jquery-1.9.1
//= require jquery_ujs
//= require front/js/jQuery.Opie.PortfolioGallery.min
//= require front/js/classie
//= require front/js/modernizr.custom
//= require front/js/jquery.sequence-min
//= require front/js/jquery.slider.min
//= require front/js/cbpScroller
//= require front/js/niceScroll
//= require front/js/jquery.counters.min
//= require front/js/hover
//= require front/js/init
//= require plugins/bootstrap/js/bootstrap.min
//= require plugins/bootstrap-datepicker/js/bootstrap-datepicker
//= require js/imagesloaded
//= require customize_front
//= require scrolltofixed-min
//= require jquery.lazyload

//= require_self


window.current_menu = 'intro';
window.is_table_loaded = false;
var    topMenu = $(".menu"),
    // All list items
    menuItems = topMenu.find("a").add($('.mbl-menu').find('a')),
    // Anchors corresponding to menu items
    scrollItems = menuItems.map(function(){
      var item = $($(this).attr("href"));
      if (item.length) { return item; }
    });

window.lazyImagesLoaded = function(){
  if(!is_table_loaded && window.current_menu == 'plan'){
    is_table_loaded = true;
    $.each($(".side_table_right"),function( index, value ){
      var color = $(value).data('color');
      var _parent = $(value).parents('.parrent_table').first();
      var total_hg = _parent.outerHeight();
      _parent.find(".head_pack").attr("style","min-height: "+total_hg+"px;background:"+color+"");
    });
  }
}

$(function() {
  $('.lazy-img').lazyload({
    effect : "fadeIn",
    threshold : 0
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
      $.get('/extra.js?extra_id='+$(this).attr('data-index')+'&add=true')
    }
    
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

  $('input[name="membership_ids[]"]').on('change', function(){
    $.get('/extra.js?extra_id='+$(this).val()+'&add='+$(this).is(':checked'))
  });

  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/id_ID/all.js#xfbml=1&appId=791578794202636";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  if($('.twitter-widget-box').length){
    $('.twitter-widget-box').html(unescape("%3Cscript src='http://twitterforweb.com/twitterbox.js?username=BiGTiVi&settings=1,1,5,236,650,000000,1,1d1f21,ffffff,1,1,336699' type='text/javascript'%3E%3C/script%3E"));
  }

  //$("#map_section").gmap3({map:{options:{scrollwheel: false}}});

  $(window).scroll(function(){
     var fromTop = $(this).scrollTop();
     var cur = scrollItems.map(function(){
     if ($(this).offset().top < fromTop)
       return this;
     });
     cur = cur[cur.length-1];
     var id = cur && cur.length ? cur[0].id : "intro";
     current_menu = id;
     if (String(id) == 'plan') {
       lazyImagesLoaded()
     }                   
  });
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
