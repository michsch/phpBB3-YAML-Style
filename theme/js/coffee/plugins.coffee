###*
 * plugins file with some jQuery plugins and standard functions
 *
 * @author             Michael Schulze
 * @version            $1.1$
 * @copyright          Michael Schulze <elsigno.de>, 29 December, 2011
 * @license            GNU General Public License, version 3 (GPL-3.0)
 * @package            coffeescript, jquery
 * @requirements       jquery-1.7.2.min.js
 *
 * @lastmodified       $Date: 2012-03-30 13:16:22 +0200 (Fr., 30 Mär 2012) $
 *
###

"use strict"

###*
usage: log('inside coolFunc', this, arguments);
paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
###
window.log = ->
  log.history = log.history or []
  log.history.push arguments
  if @console
    arguments.callee = arguments.callee.caller
    console.log Array::slice.call(arguments)

###
make it safe to use console.log always
###
((b) ->
  c = ->
  d = "assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(",")
  while a = d.pop()
    b[a] = b[a] or c
) window.console = window.console or {}

( ($) ->
  ###*
   * Accessifyhtml5.js
   * Adds ARIA to new elements in browsers which don’t do it by themselves.
   *
   * originally by Eric Eggert
   * https://github.com/yatil/accessifyhtml5.js
  ###
  $.accessifyhtml5 = ( defaults ) ->
    fixes =
      article:
        role: "article"
      aside:
        role: "complementary"
      nav:
        role: "navigation"
      output:
        "aria-live": "polite"
      section:
        role: "region"
      "[required]":
        "aria-required": "true"

    if defaults
      fixes[defaults.header] = role: "banner"  if defaults.header
      fixes[defaults.footer] = role: "contentinfo"  if defaults.footer

    $.each(fixes, (index, item) ->
      $(index).attr(item)
      true
    )

    true

  firstplugin =
    init : ( options ) ->
      defaults = 
        resize: 1
      o = $.extend(defaults, options || {})
      firstload = 1
      el = this

      # active update function if window is resized
      if o.resize == 1
        $(window).resize( ->
          firstLoad = 0
          firstplugin.update(o)
          true
        )

      this.each( ->
        # place your plugin code here
      )

    update: (o) ->
      el.each( ->
        # place your plugin code for the update function here
      )

  $.fn.firstplugin = ( method ) ->
    # Method calling logic
    if firstplugin[method]
      firstplugin[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ))
    else if typeof method == 'object' or ! method
      firstplugin.init.apply( this, arguments )
    else
      $.error( 'Method ' +  method + ' does not exist on jQuery.firstplugin' )

  $.secondplugin = ( options ) ->
    defaults =
      resize: 1
    o = $.extend(defaults, options || {})

    # place your plugin code here

    true

  true

) jQuery

###*
 * "Yet Another Multicolumn Layout" - YAML CSS Framework
 *
 * (en) Workaround for IE8 und Webkit browsers to fix focus problems when using skiplinks
 * (de) Workaround für IE8 und Webkit browser, um den Focus zu korrigieren, bei Verwendung von Skiplinks
 *
 * @note			      inspired by Paul Ratcliffe's article
 *					        http://www.communis.co.uk/blog/2009-06-02-skip-links-chrome-safari-and-added-wai-aria
 *                  Many thanks to Mathias Schäfer (http://molily.de/) for his code improvements
 *
 * @copyright       Copyright 2005-2012, Dirk Jesse
 * @license         CC-BY 2.0 (http://creativecommons.org/licenses/by/2.0/),
 *                  YAML-CDL (http://www.yaml.de/license.html)
 * @link            http://www.yaml.de
 * @package         yaml
 * @version         4.0+
 * @revision        $Revision: 617 $
 * @lastmodified    $Date: 2012-01-05 23:56:54 +0100 (Do, 05 Jan 2012) $
###
(->
  YAML_focusFix =
    skipClass: "ym-skip"
    init: ->
      userAgent = navigator.userAgent.toLowerCase()
      is_webkit = userAgent.indexOf("webkit") > -1
      is_ie = userAgent.indexOf("msie") > -1
      if is_webkit or is_ie
        body = document.body
        handler = YAML_focusFix.click
        if body.addEventListener
          body.addEventListener "click", handler, false
        else body.attachEvent "onclick", handler  if body.attachEvent

    trim: (str) ->
      str.replace(/^\s\s*/, "").replace /\s\s*$/, ""

    click: (e) ->
      e = e or window.event
      target = e.target or e.srcElement
      a = target.className.split(" ")
      i = 0

      while i < a.length
        cls = YAML_focusFix.trim(a[i])
        if cls is YAML_focusFix.skipClass
          YAML_focusFix.focus target
          break
        i++

    focus: (link) ->
      if link.href
        href = link.href
        id = href.substr(href.indexOf("#") + 1)
        target = document.getElementById(id)
        if target
          target.setAttribute "tabindex", "-1"
          target.focus()

  YAML_focusFix.init()
)()

###*
 * JavaScript email encrypter
 *
 * @author             Michael Schulze
 * @version            $1.0$
 * @copyright          Michael Schulze, 31 December, 2011
 *                     https://github.com/michsch/cryptmail
 * @license            GNU General Public License, version 3 (GPL-3.0)
 * @package            coffeescript
 *
 * @lastmodified       $Date: 2011-12-31 20:29:35  +0100 (Sat, 31 Dec 2011) $
 *
###

( (window) ->

  ###*
   * Crypt given mail
   *
   * @param string email address
   * @param boolean true
  ###
  window.CryptMailto = ->
    formname = 'cryptmail'
    cryptform = document.forms[formname]
    n = 0
    r = ""
    s = "mailto:" + cryptform.cryptmail_email.value
    e = cryptform.cryptmail_email.value
    
    if cryptform.cryptmail_email.value.length < 4
      return false
    
    radioObj = cryptform.cryptmail_radio
    if radioObj.length > 0
      i = 0
      while i < radioObj.length
        radioValue = parseInt(radioObj[i].value if radioObj[i].checked, 0)
        i++
    else
      radioValue = 0
    
    if radioValue is 1
      e = e.replace(/\./g, '<span class="crypt">.</span>.</span class="crypt">.</span>')
      e = e.replace(/@/, '<span class="crypt">.</span>@</span class="crypt">.</span>')
    else
      e = e.replace(/\./g, ' [dot] ')
      e = e.replace(/@/, ' [at] ')
    
    i = 0
    while i < s.length
      n = s.charCodeAt(i)
      n = 128  if n >= 8364
      r += String.fromCharCode(n + 1)
      i++
    cryptform.cryptmail_cryptedmail.value = r
    cryptform.cryptmail_html.value = '<a href="javascript:linkTo_UnCryptMailto(\'' + r + '\');">' + "\n\t" + e + "\n" + '</a>'
    true

  ###*
   * Uncrypt the email address and returns the valid href
   *
   * @param string the crypted string
   * @return string valid href
  ###
  UnCryptMailto = (s) ->
    n = 0
    r = ""
    i = 0

    while i < s.length
      n = s.charCodeAt(i)
      n = 128  if n >= 8364
      r += String.fromCharCode(n - 1)
      i++
    r

  ###*
   * Public function for A tags
   *
   * @param string the crypted string
   * @return boolean true
  ###
  window.linkTo_UnCryptMailto = (s) ->
    location.href = UnCryptMailto(s)
    true
  
  true

) window

###*
 * Checks if an event is supported
 *
 * @param string event to check
 * @return boolean true if event is supported, false if not
###
isEventSupported = (->
  isEventSupported = (eventName) ->
    el = document.createElement(TAGNAMES[eventName] or "div")
    eventName = "on" + eventName
    isSupported = (eventName of el)
    unless isSupported
      el.setAttribute eventName, "return;"
      isSupported = typeof el[eventName] is "function"
    el = null
    isSupported
  TAGNAMES =
    select: "input"
    change: "input"
    submit: "form"
    reset: "form"
    error: "img"
    load: "img"
    abort: "img"

  isEventSupported
)()