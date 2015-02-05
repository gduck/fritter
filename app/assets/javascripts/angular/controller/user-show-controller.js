app.controller('UserShowCtrl', ['$scope', '$http', 'UserServices', function($scope, $http, UserServices){

  console.log('this is UserShowCtrl', UserServices.id);
  // $scope.userprofile = 'Welcome to my page';


  $scope.changeName = function(){
    $scope.changing = true;
    console.log('i just opened the popup');
  }

  $scope.submitChange = function(){
    console.log('i jam trying to submit');
    $scope.changing = false;

    var data = {};
    console.log($scope.newUserName);

    if($scope.newUserName != ''){
      data.username = $scope.newUserName;
    }

    if($scope.newUserProfile != ""){
      data.userprofile = $scope.newUserProfile;
    }

console.log('data',data);

    $http.patch('/user/' + UserServices.id , data).success(function(response,status,xhr){
      console.log('i received this resons:', response);
      UserServices.username = response.username;
      UserServices.userprofile = response.userprofile;
    })

  }

  $scope.cancelChange = function(){
    console.log('i just closed the popup');
    $scope.changing = false;
    console.log($scope.newUserName);
  }

}])