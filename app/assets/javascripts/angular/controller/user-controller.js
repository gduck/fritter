app.controller('UserCtrl', ['$scope', '$http',
  function($scope, $http){

  // $http.get('user.json').success(function(data){
  //   console.log('sucess on getting users');
  //   console.log(data);
  //   $scope.user = data.user;
  // })
  
  $http.get('pins.json').success(function(data){
    console.log('success on getting pins from UserCtrl');
    $scope.pins = data.pins;
  })

  $http.get('/categories.json').success(function(data){
    console.log('sucess on get categories');
    // console.log(data);
    $scope.categories = data.categories;
  })

  $scope.open = false;
  $scope.togglePin = function(pin_id){
    console.log(pin_id);
    $http.get('pins/' + pin_id + '.json').success(function(data){
      console.log(data);
      $scope.pin = data.pins[0];
    })
    $scope.open = !$scope.open;
    console.log('click');
  }

}])