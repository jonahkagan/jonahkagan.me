(function() {
  var scrollToLink;

  $(function() {
    $("#toc li a").click(scrollToLink);
    return $(".page-header h1 small a").click(scrollToLink);
  });

  scrollToLink = function() {
    var anchorLink;
    anchorLink = $(this).attr("href");
    $("html,body").animate({
      scrollTop: $(anchorLink).offset().top - 10
    }, "slow");
    history.pushState(null, null, anchorLink);
    return false;
  };

}).call(this);
