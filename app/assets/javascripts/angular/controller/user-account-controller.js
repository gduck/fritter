
app.controller('UserAccCtrl', ['$scope', '$http', '$routeParams', 'UserServices',
  function($scope, $http, $routeParams, UserServices){

  console.log("1. UserAccCtrl");
  $scope.user = UserServices;
  $scope.message = "";

  $http.get("/user/any").success(function(response,status){
    console.log("2. http request get user/any")
    UserServices.logInStatus = response.signedIn;
    // console.log(response);
    if (response.signedIn) {
      $scope.getUser();
      console.log("3. just filled UserServices using getUser");
    };
  });

  $scope.getUser = function(){
    url = "/get_user.json"
    $http.get(url).success(function(response, status) {
      console.log("4. here in get user function");
      console.log(response);
      UserServices.email = response.user.email;
      console.log("5. just got user");
      console.log($scope.user);
    });
  }

  $scope.newUser = function(){
    console.log('user.email', $scope.user.newUserEmail);
    console.log('user.password', $scope.user.newUserPassword);
    console.log('scope', $scope);
    var url = "/users";
    var data = {
      'user': {
        'email': $scope.user.newUserEmail,
        'password': $scope.user.newUserPassword,
        'password_confirmation': $scope.user.newUserPassword
      },
      'commit': "Sign Up"
    };
    // console.log("6.", data);
    $http.post(url, data).success(function(response, status, xhr){
      UserServices.logInStatus = true;
      console.log("SUCCESSFUL response ", response);
      console.log(status);
      $scope.getUser();
      console.log("just called getUser in newUser");
    }).error(function(response) {
      console.log("problem!! - ", response.message);
      $scope.setMessage(response);
      UserServices.logInStatus = false;
    });
  }

  $scope.userSignOut = function() {
    $http.delete("/users/sign_out/").success(function(response,status){
      UserServices.logInStatus = false;
      console.log("logged out");
    })
  }

  $scope.userSignIn = function(){
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
      $scope.getUser();
      console.log("just got user");
    }).error(function(response) {
      console.log("problem!! - " + response.message);
      UserServices.logInStatus = false;
      $scope.setMessage(response.message);
    });
  }

  $scope.setMessage = function(msgHash) {
    var success = msgHash['success'];
    console.log(success);
    var errors = msgHash['message'];
    console.log(errors);

    var msg = "The ";
    var keys = [];

    if (success == false) {
      keys = Object.keys(msgHash['message']);
      console.log(keys);

      // we know here the keys has at least one item
      msg += keys[0] + " ";
      msg += errors[keys[0]];
      // and maybe has 2. It can not have 3
      if (keys.length > 1) {
        msg += " and the ";
        msg += keys[1] + " ";
        msg += errors[keys[1]];
      }
      console.log(msg);
      $scope.message = msg;
    }
  }


}])