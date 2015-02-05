app.controller('UserShowCtrl', ['$scope', '$http', 'UserServices', function($scope, $http, UserServices){

console.log('this is UserShowCtrl', UserServices.id);

  $scope.changeName = function(){
    $scope.changing = true;
    console.log('i just opened the popup');
  }

  $scope.submitChange = function(){
    console.log('i jam trying to submit');
    $scope.changing = false;
    var data = {
      username: $scope.newUserName,
      // userprofile: $scope.newUserProfile
    };
    $http.patch('/user/' + UserServices.id , data).success(function(response,status,xhr){
      console.log('i received this resons:', response);
      UserServices.username = response.username;
      // UserServices.userprofile = response.newUserProfile;
    })

  }

  $scope.cancelChange = function(){
    console.log('i just closed the popup');
    $scope.changing = false;
    console.log($scope.newUserName);
  }

}])