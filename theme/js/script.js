
/**
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
*/

(function() {
  "use strict";
  var $, lang, language, ll;

  jQuery.noConflict();

  $ = jQuery;

  language = $('html').attr('lang');

  lang = !language ? 'en' : language;

  ll = ['en', 'de'];

  ll['en'] = {
    from: 'from',
    to: 'to',
    image: 'image'
  };

  ll['de'] = {
    from: 'von',
    to: 'bis',
    image: 'Bild'
  };

  jQuery(document).ready(function($) {
    var domReady;
    domReady = {
      /**
       * Init function for that page
       *
       * @return boolean true
      */
      init: function() {
        var mobileScrollUp, self;
        self = this;
        $.accessifyhtml5();
        $('html').removeClass('no-js').addClass('js');
        mobileScrollUp = function() {
          return window.scrollTo(0, 1);
        };
        setTimeout(mobileScrollUp, 100);
        Hyphenator.run();
        $(".fancybox").fancybox();
        self.responsive(self.getWindowWidth(), false);
        $(window).resize(function() {
          return self.responsive(self.getWindowWidth(), true);
        });
        if (navigator.userAgent.indexOf("Windows") === -1 || (navigator.userAgent.indexOf("Windows") > -1 && navigator.userAgent.indexOf("Firefox") === -1)) {
          $('html').addClass('webfonts');
        }
        return true;
      },
      /**
       * Function for responsive design
       *
       * @param integer width of window in pixel
       * @param boolean true if window is resized
       *
       * @return boolean true
      */
      responsive: function(windowWidth, resize) {
        return true;
      },
      /**
       * Gets the actual window width
       *
       * @param object jQuery object
       * @return integer window width in pixel
      */
      getWindowWidth: function() {
        var ielt9, windowWidth;
        windowWidth = window.innerWidth;
        if (!windowWidth) {
          ielt9 = true;
          windowWidth = $('body').width();
        }
        return windowWidth;
      },
      /**
       * Creates the DropDown navigation with hoverIntent plugin
       *
       * @return boolean true
      */
      navigation: function() {
        var navHover;
        navHover = {
          over: navOverFunction,
          out: navOutFunction,
          timeout: 200
        };
        $("#nav div.hlist > ul:first-child > li > a").hoverIntent(navHover);
        return true;
      },
      /**
       * Main navigation mouseOver
       *
       * @return boolean true
      */
      navOverFunction: function() {
        $ = jQuery;
        if ($(this).next('ul').length > 0) {
          $(this).parent('li').addClass('hover');
          $(this).next('ul').slideDown(200);
        }
        return true;
      },
      /**
       * Main navigation mouseOut
       *
       * @return boolean true
      */
      navOutFunction: function() {
        var li, liOffset, link, ul, ulOffset;
        $ = jQuery;
        link = $(this);
        li = link.parent('li');
        ul = link.next('ul');
        liOffset = li.offset();
        ulOffset = ul.offset();
        /*
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
        */
        $('html').mousemove(function(e) {
          var posX, posY;
          posX = e.pageX;
          posY = e.pageY;
          if (posX < liOffset.left || posY < liOffset.top || posX > (liOffset.left + ul.width()) || (posY > liOffset.top && posY < (liOffset.top + li.height() + 25) && posX > (liOffset.left + li.width())) || posY > (liOffset.top + li.height() + ul.height() + 25)) {
            ul.slideUp(100, function() {
              return li.removeClass('hover');
            });
            $('html').unbind();
            return true;
          }
        });
        return true;
      },
      installSyntaxHighlighting: function() {
        var highlightStyle;
        highlightStyle = "peachpuff";
        if (jQuery.fn.snippet) {
          $("pre.htmlCode").snippet("html", {
            style: highlightStyle
          });
          $("pre.cssCode").snippet("css", {
            style: highlightStyle
          });
          $("pre.jsCode").snippet("javascript", {
            style: highlightStyle
          });
        }
        return true;
      },
      /*
           * Fancybox popup
           *
           * @return boolean true
      */
      fancyboxMore: function() {
        if ($('*').is('a.jqfancybox-more')) {
          $('a.jqfancybox-more').click(function(event) {
            var content;
            event.preventDefault();
            content = $($(this).attr('href')).html();
            return $.fancybox(content, {
              autoDimensions: true,
              width: 600,
              padding: 40,
              height: 'auto',
              transitionIn: 'none',
              transitionOut: 'none'
            });
          });
        }
        return true;
      },
      /**
       * Activate fancybox
       *
       * @return boolean true
      */
      fancybox: function() {
        var options;
        if ($("*").is(".jqfancybox")) {
          options = {
            padding: 12,
            speedIn: 300,
            speedOut: 300,
            changeSpeed: 300,
            transitionIn: "elastic",
            transitionOut: "elastic",
            titlePosition: "over",
            titleShow: true,
            easingIn: "swing",
            easingOut: "swing",
            showCloseButton: true,
            showNavArrows: true,
            enableEscapeButton: true,
            overlayShow: true,
            overlayOpacity: 0.4,
            overlayColor: "#666",
            centerOnScroll: false,
            hideOnContentClick: false,
            onComplete: function() {
              return $("#fancybox-wrap").hover(function() {
                return $("#fancybox-title").show();
              }, function() {}, $("#fancybox-title").hide());
            },
            titleFormat: function(title, currentArray, currentIndex, currentOpts) {
              return '<span id="fancybox-title-over">' + ll[lang].image + ' ' + (currentIndex + 1) + ' ' + ll[lang].from + ' ' + currentArray.length + (title.length ? ': &nbsp; ' + title : '') + '</span>';
            }
          };
          $(".jqfancybox").fancybox(options);
        }
        return true;
      }
    };
    return domReady.init();
  });

  jQuery(window).load(function() {
    var domLoad;
    $ = jQuery;
    domLoad = {
      /**
       * Init function for that page
       *
       * @return boolean true
      */
      init: function() {
        var self;
        self = this;
        return true;
      }
    };
    return domLoad.init();
  });

}).call(this);
