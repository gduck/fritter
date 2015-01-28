app.controller('UserCtrl', ['$scope', '$http', '$routeParams', 'UserServices',
  function($scope, $http, $routeParams, UserServices){

  console.log("here in the UserCtrl");
  $scope.user = UserServices;

  $http.get("/user/any").success(function(response,status){
    console.log("http request get user/any")
    UserServices.logInStatus = response.signedIn;
    console.log(response);
  });

  $scope.userSignIn = function() {
    var url = "/sessions";
    var data = {
      'user': {
        'email': $scope.userEmail,
        'password': $scope.userPassword,
        'password_confirmation': $scope.userPassword
      },
      'commit': "Sign In"
    };
    $http.post(url, data).success(function(response, status, xhr){
      console.log("response ", response);
      UserServices.logInStatus = true;
    }).error(function(response) {
      console.log("problem!! - " + response);
      UserServices.logInStatus = false;
    });
  }

  $scope.newUser = function() {
    var url = "/users";
    var data = {
      'user': {
        'email': $scope.newUserEmail,
        'password': $scope.newUserPassword,
        'password_confirmation': $scope.newUserPassword
      },
      'commit': "Sign Up"
    };
    $http.post(url, data).success(function(response, status, xhr){
      UserServices.logInStatus = true;
      console.log("SUCCESSFUL response ", response);
      console.log(status);
    }).error(function(response) {
      console.log("problem!! - " + response);
      UserServices.logInStatus = false;
    });
  }

  $scope.userSignOut = function() {
    $http.delete("/users/sign_out/").success(function(response,status){
      UserServices.logInStatus = false;
      console.log("ANYTHING DAMMIT");
    })
  }

}])