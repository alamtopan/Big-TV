(function($){
	"use strict";
	
	/**
	 * Initalize scroller
	 */
	var animating = false;
	var lastId,
		topMenu = $(".menu"),
		// All list items
		menuItems = topMenu.find("a").add($('.mbl-menu').find('a')),
		// Anchors corresponding to menu items
		scrollItems = menuItems.map(function(){
		  var item = $($(this).attr("href"));
		  if (item.length) { return item; }
		});

	// Bind click handler to menu items
	// so we can get a fancy scroll animation
	menuItems.click(function(e){
		animating = true;
	  var href = $(this).attr("href"),
		  offsetTop = href === "#" ? 0 : $(href).offset().top+1;
	  $('html, body').stop().animate({ 
		  scrollTop: offsetTop
	  }, 1500, 'easeInQuint', function(){
		  animating = false;
	  });
	  e.preventDefault();
	});

	// Bind to scroll
	$(window).scroll(function(){
	  if (animating === false) {
	   // Get container scroll position
	   var fromTop = $(this).scrollTop();
	   // Get id of current scroll item
	   var cur = scrollItems.map(function(){
		 if ($(this).offset().top < fromTop)
		   return this;
	   });
	   // Get the id of the current element
	   cur = cur[cur.length-1];
	   var id = cur && cur.length ? cur[0].id : "intro";
	   if (lastId !== id) {
		   lastId = id;
		   // Set/remove active class
		   menuItems
			 .removeClass("selected")
			 .filter("[href=#"+id+"]").addClass("selected");
	   }                   
	}});
 
	/**
	 * Intialize sliders
	 */
	$('.feature_cont_slider_mobile .feature_cont').parallaxSlider({
		elements: [{SEL: '.feature'}],
		SEL_paging: '#feature_cont_slider_mobile_paging'
	});
	$('.team_members').parallaxSlider({
		elements: [{SEL: '.member'}],
		SEL_paging: '#team_members_paging'
	});
	$('.features-cont-sub').parallaxSlider({
		elements: [{SEL: '.feedback-as'}],
		SEL_paging: '#features-cont-sub-paging'
	});
	$(window).resize(function(){
		if ($(this).width() > 720){
			$('.feature_cont_slider_mobile .feature_cont')
				.add('.team_members')
				.add('.features-cont-sub')
				.add('.mbl-profits-cont')
				.css({'margin-left' : 'auto'});
			window.paralaxSliderDisable = true;
			$('.mbl-paging').each(function(){
				$(this).children('.dot').removeClass('selected').first().addClass('selected');
			});
		}else{
			window.paralaxSliderDisable = false;
		}
	});
	if ($(this).width() > 720){
		window.paralaxSliderDisable = true;
	}else{
		window.paralaxSliderDisable = false;
	}
	
	/**
	 * Intialize nice scroll
	 */
	$("html").niceScroll();
	
	/**
	 * Initilize cbpScroller (fixed background)
	 */
	$('.cbp-so-scroller').each(function(){
		new cbpScroller( this );
	});
	
	/**
	 * Portfolio initialize
	 */
	$(".opie-portfolio").OpiePortfolioGallery({
		maxBoxSize : 195,
		boxMovementDuration : 600,
		delayIncrease : 25,
		delayStart : 0,
		maxDelay : 300,
		scrollingAid : true,
		boxPositionEasing : 'easeOutSine',
		extraInfoOpenDuration : 450,
		extraInfoOpenEasing : 'easeOutSine',
		extraInfoCloseDuration : 400,
		extraInfoCloseEasing : 'easeOutSine',
		boxOpenEasing : 'easeOutSine',
		boxOpenDuration : 600,
		boxCloseEasing : 'easeOutSine',
		boxCloseDuration : 450,
		userCSS3Accelerate : false,
		filterNavSelector : '#portfolioNav a',
		dontResizeThumbs : false,
		useCentering : false
	});
	
	/**
	 * Popups initialize
	 */
	$('#feedback_button').click(function(){
		$('.feedback_popup').add('.mask').fadeIn();
	});
	$('#mbl-button').click(function(){
		if ($('#mbl-menu').is(':visible')){
			$('#mbl-menu').fadeOut();
		} else{
		$('#mbl-menu').fadeIn();
		}
	});
	$('#mbl-menu a').click(function(){
		$('#mbl-menu').fadeOut();
	});
	$('.login').click(function(){
		$('.login_form').add('.mask').fadeIn();
	});
	$('.mask').click(function(){
		$('.feedback_popup').add('.login_form').add('.mask').fadeOut();
	});
	
	/**
	 * Initialize paralax slider (Sequence)
	 */
	var options = { 
		autoPlay: true,
		autoPlayDelay: 700,
		pauseOnHover: true,
		pagination: '.dots'
	};
	var mySequence = $("#sequence").sequence(options).data("sequence"); /* initiate Sequence */
	
	/**
	 * Slider packs initialize
	 */
	$('#slider-packs').parallaxSlider({
		SEL_paging	: '#mbl-paging-packs',
		speed_cont: 800
	});
	var animated = false;
	function resizeDefine(){
		if ($(this).width() > 720){
			$('.pack').find('.mbl-pack-mask').hide();
			$('.mbl-packs-cont').css({'margin-left': 'auto'});
		}else{
			$('.pack').first().add($('.pack').last()).find('.mbl-pack-mask').show();
			$('.mbl-packs-cont').css({'margin-left': '-440px'});
		}
	}
	$(window).resize(resizeDefine);
	$(window).resize();
	
	$('.pack').hover(function(){
		if (!$(this).find('.mbl-pack-mask').is(':visible')) return;
		if (animated) return;
		
		animated = true;
		
		var num = $(this).index();
		var currentPosition = parseInt($('.mbl-packs-cont').css('margin-left'), 10);
		$(this).find('.mbl-pack-mask').fadeOut();
		
		var elToMask;
		if (num == 0 || num == 1)
		{
			elToMask = $('.mbl-packs-cont').find('.pack').eq(num + 2);
		}
		else
		{
			elToMask = $('.mbl-packs-cont').find('.pack').eq(num - 2);
		}
		elToMask.find('.mbl-pack-mask').fadeIn();
		
		
		var toAnimate = (num == 0 || num == 1) ? (currentPosition + $(this).width()) : (currentPosition - $(this).width());
		$('.mbl-packs-cont').animate({
			'margin-left' : toAnimate
		}, function(){
			animated = false;
		});
		
	}, function(){
		// nothing here. yay
	});
})(jQuery);