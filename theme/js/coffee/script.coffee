###*
 * main jQuery script file
 *
 * @author             Michael Schulze
 * @version            $1.1$
 * @copyright          Michael Schulze <elsigno.de>, 29 December, 2011
 * @license            All rights reserved. No usage without written permission.
 * @package            coffeescript, jquery
 * @requirements       jquery-1.7.2.min.js
 *
 * @lastmodified       $Date: 2012-03-30 13:14:14 +0200 (Fr., 30 Mär 2012) $
 *
###

"use strict"

jQuery.noConflict()

$ = jQuery

language = $('html').attr('lang')
lang = if !language then 'en' else language

ll = ['en', 'de']
ll['en'] =
	from: 'from'
	to: 'to'
	image: 'image'
ll['de'] =
	from: 'von'
	to: 'bis'
	image: 'Bild'

jQuery(document).ready ($) ->
  
  domReady =
    
    ###*
     * Init function for that page
     *
     * @return boolean true
    ###
    init : ->
      self = this

      $.accessifyhtml5()
      $('html').removeClass('no-js').addClass('js')

      mobileScrollUp = -> window.scrollTo(0, 1)
      setTimeout mobileScrollUp,100

      # Functions
      Hyphenator.run()
      # self.installSyntaxHighlighting()

      $(".fancybox").fancybox();

      # Responsive view
      self.responsive(self.getWindowWidth(), false)
      $(window).resize -> self.responsive(self.getWindowWidth(), true)

      if navigator.userAgent.indexOf("Windows") == -1 or (navigator.userAgent.indexOf("Windows") > -1 and navigator.userAgent.indexOf("Firefox") == -1)
        $('html').addClass('webfonts')

      true
  
    ###*
     * Function for responsive design
     *
     * @param integer width of window in pixel
     * @param boolean true if window is resized
     *
     * @return boolean true
    ###
    responsive : (windowWidth, resize) ->

    	# do everytime when window is resized

    	# in a special range
    	#if windowWidth <= 768 and windowWidth > 480

    	# smaller than x
    	#if windowWidth <= 840

    	#if windowWidth <= 768

    	#if windowWidth <= 640

    	#if windowWidth <= 520

    	#if windowWidth <= 480


    	# larger than x
    	#if windowWidth > 840

    	#if windowWidth > 768

    	#if windowWidth > 640

    	#if windowWidth > 520

    	# do only after first loading
    	#if resize == false

    	# do only if window is resizing
    	#if resize == true

    	true

    ###*
     * Gets the actual window width
     *
     * @param object jQuery object
     * @return integer window width in pixel
    ###
    getWindowWidth : ->
    	windowWidth = window.innerWidth
    	if !windowWidth
    		ielt9 = true
    		windowWidth = $('body').width()
    	windowWidth

    ###*
     * Creates the DropDown navigation with hoverIntent plugin
     *
     * @return boolean true
    ###
    navigation : ->
    	navHover =
    		over : navOverFunction
    		out : navOutFunction
    		timeout: 200

    	$("#nav div.hlist > ul:first-child > li > a").hoverIntent( navHover )

    	true

    ###*
     * Main navigation mouseOver
     *
     * @return boolean true
    ###
    navOverFunction : ->
    	$ = jQuery

    	if $(this).next('ul').length > 0
    		$(this).parent('li').addClass('hover')
    		$(this).next('ul').slideDown(200)

    	true;

    ###*
     * Main navigation mouseOut
     *
     * @return boolean true
    ###
    navOutFunction : ->
      $ = jQuery

      link = $(this)
      li = link.parent('li')
      ul = link.next('ul')
      liOffset = li.offset()
      ulOffset = ul.offset()

      ###
      $('html').mousemove((e) ->
          window.posX = e.pageX
          window.posY = e.pageY
          true
        )

      checkMouseOver = window.setInterval( ->
          posX = window.posX
          posY = window.posY

          if posX < liOffset.left or
            posY < liOffset.top or
            posX > (liOffset.left + ul.width()) or
            (posY > liOffset.top and posY < (liOffset.top + li.height() + 25) and posX > (liOffset.left + li.width()) ) or
            posY > (liOffset.top + li.height() + ul.height() + 25)

              ul.slideUp(100, -> li.removeClass('hover') )
              window.clearInterval(checkMouseOver)
              true
        ,100)
      ###

      $('html').mousemove((e) ->
      		posX = e.pageX
      		posY = e.pageY

      		if posX < liOffset.left or
      			posY < liOffset.top or
      			posX > (liOffset.left + ul.width()) or
      			(posY > liOffset.top and posY < (liOffset.top + li.height() + 25) and posX > (liOffset.left + li.width()) ) or
      			posY > (liOffset.top + li.height() + ul.height() + 25)

      				ul.slideUp(100, -> li.removeClass('hover') )
      				$('html').unbind()
      				true
        )
      true

    installSyntaxHighlighting : ->
      highlightStyle = "peachpuff"

      if jQuery.fn.snippet
        $("pre.htmlCode").snippet("html", {style: highlightStyle})
        $("pre.cssCode").snippet("css", {style: highlightStyle})
        $("pre.jsCode").snippet("javascript", {style: highlightStyle})
      true

    ###
     * Fancybox popup
     *
     * @return boolean true
    ###
    fancyboxMore : ->
      if $('*').is('a.jqfancybox-more')
        $('a.jqfancybox-more').click( (event) ->
          event.preventDefault()
          content = $($(this).attr('href')).html()
          $.fancybox(
            content
            {
              autoDimensions	: true
              width      		  : 600
              padding         : 40
              height     	  	: 'auto'
              transitionIn		: 'none'
              transitionOut		: 'none'
            }
          )
        )
      true

    ###*
     * Activate fancybox
     *
     * @return boolean true
    ###
    fancybox : ->
    	if $("*").is(".jqfancybox")
    		options =
    			padding: 12
    			speedIn: 300
    			speedOut: 300
    			changeSpeed: 300
    			transitionIn: "elastic"
    			transitionOut: "elastic"
    			titlePosition: "over"
    			titleShow: true
    			easingIn: "swing"
    			easingOut: "swing"
    			showCloseButton: true
    			showNavArrows: true
    			enableEscapeButton: true
    			overlayShow: true
    			overlayOpacity: 0.4
    			overlayColor: "#666"
    			centerOnScroll: false
    			hideOnContentClick: false
    			onComplete: ->
    				$("#fancybox-wrap").hover( ->
    				  $("#fancybox-title").show()
    					, ->
    					$("#fancybox-title").hide()
    				)
    			titleFormat: (title, currentArray, currentIndex, currentOpts) ->
    				'<span id="fancybox-title-over">' + ll[lang].image + ' ' + (currentIndex + 1) + ' ' + ll[lang].from + ' ' + currentArray.length + (if title.length then ': &nbsp; ' + title else '') + '</span>'

    		$(".jqfancybox").fancybox( options )

    	true
  
  domReady.init()

jQuery(window).load ->
  $ = jQuery
  
  domLoad =

    ###*
     * Init function for that page
     *
     * @return boolean true
    ###
    init : ->
      self = this

      true
  
  domLoad.init()