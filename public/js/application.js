$(document).ready(function(){
  $('tr.events').click( function() {
    window.location = $(this).data('link');
  }).hover( function() {
      $(this).toggleClass('hover');
  });
});
