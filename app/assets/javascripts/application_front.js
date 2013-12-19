//= require front/js/jquery-1.9.1
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

//= require_self
  

	$(document).ready(function(){
		jQuery('#nav').scrollToFixed({ marginTop: 0});
		$('#sequence').imagesLoaded(function(img){
			$(window).resize(function(){
				var imgHeight = $('.info img').height();
				$('.cont, .slide-main, .wraper2 , #sequence').css('height', imgHeight+'px');

				var imgHeight = $('.info img').height();
				$('.cont, .slide-main, .wraper2 , #sequence').css('height', imgHeight+'px');
			}).resize();
		});

		// $(window).scroll(function(){
		//   if($(window).scrollTop() > $('.table-responsive .head_pack:first').offset().top){
		//   	$('.table-responsive .head_pack').show();
		//     $('.table-responsive .head_pack').css('position','fixed').css('top','0');
		//   } else if($(window).scrollTop() > 3024) {
		//   	$('.table-responsive .head_pack').fadeOut();
		//     $('.table-responsive .head_pack').css('position','block');
		//     $('#navigation').css('position','static');
		//   }    
		// });
		//$(window).on('resize', function(){
			// $.each($('.info img'), function(){
			// 	$.image = $(this)
			// 	console.log($.image)
			// 	$.image.on('load', function(){
			// 		console.log(imgHeight)
   //        var imgHeight = $(this).height();
          
			// 		$('.cont, .slide-main, .wraper2 , #sequence').css('height',  imgHeight +'px');
			// 		var hdHeight = $('.wraper.head').height();
			// 		$('.head_bander').css('height', hdHeight+'px');
			// 	})
			// })
			
	//	}).resize();
	});