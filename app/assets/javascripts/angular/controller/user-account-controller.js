app.controller('UserAccCtrl', ['$scope', '$http', 'UserServices',
  function($scope, $http, UserServices){

  $scope.user = UserServices;

  $http.get("/user/get").success(function(response,status){
    console.log(response);
    UserServices.signedIn = response.signedIn;
    UserServices.username = response.username;
    UserServices.email = response.email;
  });
  

}])