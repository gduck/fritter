app.controller('UserSignInCtrl', ['$scope', '$http',
  function($scope, $http){

  // $http.get('user.json').success(function(data){
  //   console.log('sucess on getting users');
  //   console.log(data);
  //   $scope.user = data.user;
  // })

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

}])