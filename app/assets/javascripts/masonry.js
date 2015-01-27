$(document).ready(function(){
  $('#masonry-container').masonry({
    itemSelector: '.box',
    columnWidth: 230,
    isAnimated: !Modernizr.csstransitions
    // isRTL: true,
    // isFitWidth: true
    });
  console.log('hello masonry');
  console.log('I see', $('.box').length, 'boxes');
});
