app.controller('UserAccCtrl', ['$scope', '$http', '$location', 'UserServices',
  function($scope, $http, $location, UserServices){
    console.log('Im the UserAccCtrl!');
  $scope.user = UserServices;
  //console.log("I am not needed anymore. why am I here?");

  $scope.getUserDetails = function() {
    $http.get("/user/get.json").success(function(response,status){
      console.log("the user services response is ", response);
      UserServices.signedIn = response.signedIn;
      UserServices.id = response.id;
      UserServices.username = response.username;
      UserServices.email = response.email;
      console.log("in get user details, UserServices: ", UserServices);
    });
  }
  // $scope.getUserDetails();

  $scope.userSignUp = function() {
    var url = "/users";
    var data = {
      'user': {
        'email': $scope.signupEmail,
        'username': $scope.signupUsername,
        'password': $scope.signupPassword,
        'password_confirmation': $scope.signupPassword
      },
      'commit': "Sign Up"
    };
    console.log("this is the data before sign up ", data);
    console.log("this is scope  ", $scope);
    $http.post(url, data).success(function(response, status, xhr){
      UserServices.signedIn = true;
      console.log("SUCCESSFUL response ", response);
      console.log(status);
      $scope.getUserDetails();
      console.log("USER SIGNUP current user ", UserServices);
      // $location.path("/user");
    }).error(function(response) {
      console.log("problem!! - " + response);
      UserServices.signedIn = false;
    });
  }

  $scope.userSignIn = function() {
    var url = "/users/sign_in";
    var data = {
      'user': {
        'email': $scope.signinEmail,
        'password': $scope.signinPassword,
        'password_confirmation': $scope.signinPassword
      },
      'commit': "Sign In"
    };
    $http.post(url, data).success(function(response, status, xhr){
      console.log("SUCCESSFUL signin response ", response);
      UserServices.signedIn = true;
      $scope.getUserDetails();
      //$location.path("/user");
    }).error(function(response) {
      console.log("problem!! - " + response);
      UserServices.signedIn = false;
    });
  };  

  $scope.userSignOut = function(){
    // var data = UserServices.id;
    var data = "?id=12";
    console.log(data);
    console.log("about to logout");
    $http.delete("/users/sign_out.json").success(function(response,status){
      console.log(response);
      $scope.getUserDetails();
      //UserServices.signedIn = false;
      //$location.path("/");
    }).error(function(response,status){
      console.log("ERROR in signout");
      console.log(response);
      console.log(status);
    });
  };

}])