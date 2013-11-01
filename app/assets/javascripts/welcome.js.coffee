# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# Login Form

$(document).ready ->
  $("#login-trigger").click ->
    $(this).next("#login-content").slideToggle()
    $(this).toggleClass "active"
    if $(this).hasClass("active")
      $(this).find("span").html "&#x25B2;"
    else
      $(this).find("span").html "&#x25BC;"

