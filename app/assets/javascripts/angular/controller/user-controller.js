app.controller('UserCtrl', ['$scope', '$http', '$routeParams', function($scope, $http, $routeParams){

  // $http.get('user.json').success(function(data){
  //   console.log('sucess on getting users');
  //   console.log(data);
  //   $scope.user = data.user;
  // })
<<<<<<< HEAD
  
  $http.get('pins.json').success(function(data){
    console.log('success on getting pins from UserCtrl');
    $scope.pins = data.pins;
  })

  $http.get('/categories.json').success(function(data){
    console.log('sucess on get categories');
    // console.log(data);
    $scope.categories = data.categories;
  })
=======

  console.log("here in the UserCtrl");
  $scope.user = UserServices;

  $http.get("/user/any").success(function(response,status){
    console.log("http request get user/any")
    UserServices.logInStatus = response.signedIn;
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
>>>>>>> added userServices service, creating a user object in which to store logged in status to share throughout the app

}])