app.controller('UserSignUpCtrl', ['$scope', '$http',
  function($scope, $http){

  // $http.get('user.json').success(function(data){
  //   console.log('sucess on getting users');
  //   console.log(data);
  //   $scope.user = data.user;
  // })

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

