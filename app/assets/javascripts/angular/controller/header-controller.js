app.controller('HeaderCtrl', ['$scope', '$http', '$routeParams', '$location', 'UserServices', function($scope, $http, $routeParams, $location, UserServices){
  
  console.log("im in header ctrl");

  $scope.user = UserServices;

  $scope.resetUser = function() {
    $http.get("/user/get.json").success(function(response,status){
      //console.log("the user services response is ", response);
      UserServices.signedIn = response.signedIn;
      UserServices.id = response.id;
      UserServices.username = response.username;
      UserServices.email = response.email;
      console.log("in get user details, UserServices: ", UserServices);
    });  
  }  
  $scope.resetUser();

  $scope.toggleUserView = function() {
    console.log("toggling");
    console.log($scope.user.viewUser);
    $scope.user.viewUser = !($scope.user.viewUser);
    console.log($scope.user.viewUser);
  }

}])