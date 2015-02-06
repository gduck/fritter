app.controller('UserAccCtrl', ['$scope', '$rootScope', '$http', '$location', 'UserServices',
  function($scope, $rootScope, $http, $location, UserServices){
  
  $scope.user = UserServices;

  // watch and emit functions for UserService
  $rootScope.$on('userDetails', function(event, args) {
    console.log("In watch function header controller, args: ", args);
    $scope.user = args;
  });

  $scope.getUserDetails = function() {
    $http.get("/user/get.json").success(function(response,status){
      console.log('i receive this response: ',response);
      UserServices.signedIn = response.signedIn;
      UserServices.id = response.id;
      UserServices.username = response.username;
      UserServices.userprofile = response.userprofile;
      UserServices.email = response.email;
      console.log("in get user details, UserServices: ", UserServices);
      // console.log("the user services response is ", response);
    });
  }

  $scope.userSignIn = function() {
    $scope.user.signIn($scope.signinEmail, $scope.signinPassword);
  }
  $scope.userSignUp = function() {
    $scope.user.signUp($scope.signupEmail, $scope.signupUsername, $scope.signupPassword);
  }

  $scope.userSignOut = function(){
    // var data = UserServices.id;
    //var data = "?id=12";
    //console.log(data);
    console.log("about to logout");
    $scope.user.openUser = false;
    $http.delete("/users/sign_out.json").success(function(response,status){
      console.log(response);
      $scope.getUserDetails();
      UserServices.signedIn = false;
      $location.path("/");
      $scope.user.openUser = false;
    }).error(function(response,status){
      console.log("ERROR in signout");
      console.log(response);
      console.log(status);
    });
  };



}])
