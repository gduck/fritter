app.controller('HeaderCtrl', ['$scope', '$http', '$routeParams', '$location', 'UserServices', function($scope, $http, $routeParams, $location, UserServices){
  
  console.log("im in header ctrl");

  $scope.user = UserServices;
  if ($location.path() == '/profile') { $scope.user.viewUser = true; }
  else { $scope.user.viewUser = false; }

  $scope.resetUser = function() {
    $http.get("/user/get.json").success(function(response,status){
      UserServices.signedIn = response.signedIn;
      UserServices.id = response.id;
      UserServices.username = response.username;
      UserServices.email = response.email;
      UserServices.userprofile = response.userprofile;
      console.log("in get user details, UserServices: ", UserServices);
    });  
  }  
  $scope.resetUser();

  $scope.setUserView = function() {
    console.log("not doing anything right now");
    $location.path('/profile');
  }

  $scope.goHome = function() {
    $location.path("/");
  }

  // Modal for Sign in Sign out part
  $scope.user.openUser = false;
  $scope.openModal = function(){
    console.log('openModal');
    $scope.user.openUser = true;
  }
  $scope.closeModal = function(){
    console.log('closeModal');
    $scope.user.openUser = false;
  }

}])
