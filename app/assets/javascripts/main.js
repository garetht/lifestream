$(function() {
  var currentMode = 'edit';
  var container = $('.edit_area');
  var header = $('#header');
  var headerHeight = header.outerHeight();
  var titleHeight = $('#header h1').outerHeight();
  var fixedTop = -titleHeight;
  var scrollTops = {
    'edit' : 0,
    'preview' : 0
  };

  var isEdited = false;

  $(window).scroll(function() {
    var scrollTop = $(window).scrollTop();
    scrollTops[currentMode] = scrollTop;
    if ((scrollTop > titleHeight)) {
      header.css({
        'position' : 'fixed',
        'top' : fixedTop + 'px',
        'z-index' : '100'
      });

      container.css({
        'margin-top'  : headerHeight + 'px'
      });

    } else {
      header.css('position', 'static');
      container.css({
        'margin-top'  : 0
      });
    }
  });

  $('#markdown').bind('keyup', function() {
    isEdited = true;
    $('#output').html(markdown.toHTML($('#markdown').val()));
    window.alert("pressed")
    console.log("initializing highlighting");
    hljs.initHighlighting();
  });

  //clear
  $('#clearButton').click(function(event) {
    event.preventDefault();
    if (window.confirm('Are you sure you want to delete?')) {
      $('#markdown').val('');
    }
  });

  //autoresize
  $('textarea').autosize();
  
  $('#markdown').focus();

  //leave
  $(window).bind('beforeunload', function() {
    if (isEdited) {
      return 'Are you sure you want to leave? Your changes will be lost.';
    }
  });
});
