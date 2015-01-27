$(document).ready(function(){
  $('#masonry-container').masonry({
    itemSelector: '.box',
    columnWidth: 230,
    // gutterWith: 40,
    isAnimated: !Modernizr.csstransitions
    // isRTL: true,
    // isFitWidth: true
  });

  console.log('hello masonry');
  console.log('I see', $('.box').length, 'boxes');

  // $container.infinitescroll({
  //     // selector for the paged navigation
  //     navSelector  : '#page-nav',
  //     // selector for the NEXT link (to page 2)
  //     nextSelector : '#page-nav a',
  //     // selector for all items you'll retrieve
  //     itemSelector : '.box',
  //     loading: {
  //         finishedMsg: 'No more pages to load.',
  //         img: 'http://i.imgur.com/6RMhx.gif'
  //     }
  // },
  // // trigger Masonry as a callback
  // function(newElements){
  //   // hide new items while they are loading
  //   var $newElems = $( newElements ).css({ opacity: 0 });
  //   // ensure that images load before adding to masonry layout
  //   $newElems.imagesLoaded(function(){
  //     // show elems now they're ready
  //     $newElems.animate({ opacity: 1 });
  //     $container.masonry( 'appended', $newElems, true );
  //   });
  // });
});
