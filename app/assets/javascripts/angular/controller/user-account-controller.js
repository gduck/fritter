app.controller('UserAccCtrl', ['$scope', '$http', 'UserServices',
  function($scope, $http, UserServices){

  $scope.user = UserServices;

  $http.get("/user/get").success(function(response,status){
    console.log(response);
    UserServices.signedIn = response.signedIn;
    UserServices.username = response.username;
    UserServices.email = response.email;
  });
  

$scope.userSignIn = function() {
    var url = "/sessions";
    var data = {
      'user': {
        'email': $scope.signinEmail,
        'password': $scope.signinPassword,
        'password_confirmation': $scope.signinPassword
      },
      'commit': "Sign In"
    };
    $http.post(url, data).success(function(response, status, xhr){
      console.log("response ", response);
      UserServices.signedIn = true;
    }).error(function(response) {
      console.log("problem!! - " + response);
      UserServices.signedIn = false;
    });
  }

  $scope.userSignUp = function() {
    var url = "/users";
    var data = {
      'user': {
        'email': $scope.signupEmail,
        'password': $scope.signupPassword,
        'password_confirmation': $scope.signupPassword
      },
      'commit': "Sign Up"
    };
    $http.post(url, data).success(function(response, status, xhr){
      UserServices.signedIn = true;
      console.log("SUCCESSFUL response ", response);
      console.log(status);
    }).error(function(response) {
      console.log("problem!! - " + response);
      UserServices.signedIn = false;
    });
  }


}])