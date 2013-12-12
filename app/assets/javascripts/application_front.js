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
//= require map/gmap3.min
//= require map/map
//= require_self

	$(document).ready(function(){
		$('#sequence').imagesLoaded(function(img){
			$(window).resize(function(){
				var imgHeight = $('.info img').height();
				$('.cont, .slide-main, .wraper2 , #sequence').css('height', imgHeight+'px');

				var imgHeight = $('.info img').height();
				$('.cont, .slide-main, .wraper2 , #sequence').css('height', imgHeight+'px');
			}).resize();
		})
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