app.controller('UserCtrl', ['$scope', '$http', '$location', 'UserServices',
  function($scope, $http, $location, UserServices){

  // $http.get('user.json').success(function(data){
  //   console.log('sucess on getting users');
  //   console.log(data);
  //   $scope.user = data.user;
  // })

  if (!UserServices.signedIn) {
    console.log("redirecting....");
    $location.path('/user/user-account.html');
  } else {
    $scope.user = UserServices;
  }

  $http.get('pins.json').success(function(data){
    //console.log('success on getting pins from UserCtrl');
    $scope.pins = data.pins;
  })

  $http.get('/categories.json').success(function(data){
    //console.log('success on get categories');
    // console.log(data);
    $scope.categories = data.categories;
  })

  $scope.open = false
  $scope.openPin = function(pin_id){
    console.log(pin_id);
    $http.get('pins/' + pin_id + '.json').success(function(data){
      console.log(data);
      $scope.pin = data.pins[0];
    })
    $scope.open = !$scope.open;
    console.log('click');
  }
  $scope.closePin = function(){
    $scope.open = !$scope.open;
  }

}])