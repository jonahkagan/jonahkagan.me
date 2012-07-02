$ ->
  #less.watch()

  $toc = $("#toc")

  $("#projects section").each (i) ->
    $sect = $(this)
    anchorLink = "#" + $sect.attr "id"

    $("<li>" +
        "<a href=\"" + anchorLink + "\">" +
          $sect.find("h2 a").text() +
        "</a>" +
      "</li>")
      .appendTo($toc)
      .find("a").click scrollToLink

  $(".page-header h1 small a").click scrollToLink

scrollToLink = ->
  anchorLink = $(this).attr "href"
  $("html,body").animate
    scrollTop: $(anchorLink).offset().top - 10
    "slow"

  # simulate following the link to the browser
  history.pushState null, null, anchorLink
  # return false so we don't actually follow the link
  # on the anchor
  false
