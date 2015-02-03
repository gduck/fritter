app.controller('UserAccCtrl', ['$scope', '$http', '$location', 'UserServices',
  function($scope, $http, $location, UserServices){
    console.log('Im the UserAccCtrl!');
  $scope.user = UserServices;


  

}])