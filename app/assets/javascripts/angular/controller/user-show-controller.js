app.controller('UserCtrl', ['$scope', '$http',
  function($scope, $http){


  // $http.get('user.json').success(function(data){
  //   console.log('sucess on getting users');
  //   console.log(data);
  //   $scope.user = data.user;
  // })
  
    $http.get('pins.json').success(function(data){
    console.log('sucess on getting pins');
    $scope.pins = data.pins;
  })

}])