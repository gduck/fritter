app.controller('UserCtrl', ['$scope', '$http', '$routeParams', function($scope, $http, $routeParams){

  $http.get('pins.json').success(function(data){
    console.log('success on getting pins from UserCtrl');
    $scope.pins = data.pins;
  })

  $http.get('/categories.json').success(function(data){
    console.log('sucess on get categories');
    // console.log(data);
    $scope.categories = data.categories;
  })
  
}])
