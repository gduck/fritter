app.controller('PinCtrl', ['$scope', '$http', '$routeParams',
  function($scope, $http, $routeParams){

  // $http.get('pins.json').success(function(data){
  //   console.log('sucess on getting pins on PinCtrl');
  //   $scope.pins = data.pins;
  // })

  console.log('sure!');
  $http.get('pins/'+$routeParams.id + '.json').success(function(data){
    console.log('success on getting pin on pinctrl');
    $scope.pin = data.pin;
  })

}])