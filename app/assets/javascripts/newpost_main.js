$(function() {
  var currentMode = 'edit';
  var header = $('#header');
  var container = $('#container');
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

  // $("#markdown-edit").bind("input change propertychange paste keyup", function(){
  //   isEdited = true;
  //   LSParser.parse($("#markdown-edit").val())
  //   $('#output').html(markdown.toHTML($('#markdown-edit').val()));
  // })

  $('#markdown-edit').on('keyup change', function() {
    isEdited = true;
    LSParser.parse($("#markdown-edit").val());
    $('#output').html(markdown.toHTML($('#markdown-edit').val()));
  });

  //clear
  $('#clearButton').click(function(event) {
    event.preventDefault();
    if (window.confirm('Are you sure you want to delete?')) {
      $('#markdown-edit').val('');
    }
  });

  //autoresize
  $('textarea').autosize();
  $('#markdown-edit').focus();

});
