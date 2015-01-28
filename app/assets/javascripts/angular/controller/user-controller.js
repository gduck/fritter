app.controller('UserCtrl', ['$scope', '$http',
  function($scope, $http){

  // $http.get('user.json').success(function(data){
  //   console.log('sucess on getting users');
  //   console.log(data);
  //   $scope.user = data.user;
  // })

  $scope.user = UserServices;

  $http.get("/user/any").success(function(response,status){
    UserServices.status = response.signedIn;
  });

  $scope.userSignIn = function() {
    var url = "/sessions";
    var data = {
      'user': {
        'email': $scope.userEmail,
        'password': $scope.userPassword,
        'password_confirmation': $scope.userPassword
      }
    }
    $http.post(url, data).success(function(response, status, xhr){
      console.log("response ", response);
    }).error(function(response) {
      console.log("problem!! - " + response);
    })   
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
      console.log("SUCCESSFUL response ", response);
      console.log(status);
    }).error(function(response) {
      console.log("problem!! - " + response);
    })
  }

  $scope.userSignOut = function() {
    $http.delete("/users/sign_out/").success(function(response,status){
      UserServices.status = false;
    })
  }

}])