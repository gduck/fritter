app.controller('DemoCtrl', function ($scope,Reddit) {
  $scope.bricks  = new Reddit();
    function genBrick() {
      return {
          src: 'http://lorempixel.com/g/400/200/?' + ~~(Math.random() * 10000)
      };
  };

  $scope.remove = function remove() {
      $scope.bricks.splice(
          ~~(Math.random() * $scope.bricks.length),
          1
      )
  };
  console.log($scope.bricks);
})

app.factory('Reddit', function($http) {
  var Reddit = function() {
    this.items = [
  
    {'src':'http://lorempixel.com/350/200/sports/1', 'title':'Lorem Ipsum and shit'},
    {'src':'http://lorempixel.com/350/200/sports/2', 'title':'Lorem Ipsum and shit'},
    {'src':'http://lorempixel.com/350/200/sports/3/', 'title':'Lorem Ipsum and shit'},
    {'src':'http://lorempixel.com/320/200/sports/7/', 'title':'Lorem Ipsum and shit'},
    {'src':'http://lorempixel.com/460/350/food/2/', 'title':'Lorem Ipsum and shit'},
    {'src':'http://lorempixel.com/320/400/food/2/', 'title':'Lorem Ipsum and shit'},
    {'src':'http://lorempixel.com/320/200/food/4/', 'title':'Lorem Ipsum and shit'},
    {'src':'http://lorempixel.com/450/400/food/2/', 'title':'Lorem Ipsum and shit'},
    {'src':'http://lorempixel.com/500/350/sports/5/', 'title':'Lorem Ipsum and shit'},

    ];
    this.busy = false;
    
    this.after = '';
  };

  Reddit.prototype.nextPage = function() {
    if (this.busy) return;
    function getRandomInt(min, max) {
      return Math.floor(Math.random() * (max - min + 1) + min);
    }
    this.busy = true;
    
    var url = "http://api.reddit.com/hot?after=" + this.after + "&jsonp=JSON_CALLBACK";
    $http.jsonp(url).success(function(data) {
      
      // console.log("page " + ii);
         
       //var width=300;
       var items = data.data.children;
       
       for (var i = 0; i < items.length - 20; i++) {

         this.items.push({'src':'http://lorempixel.com/320/'+ getRandomInt(20,50) +'0/?5142','title':'"' + items[i].data.title +'"'});
       };


      this.busy = false;


      

    }.bind(this));
  };

  return Reddit;
});