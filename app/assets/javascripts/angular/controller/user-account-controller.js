app.controller('UserAccCtrl', ['$scope', '$rootScope', '$http', '$location', 'UserServices',
  function($scope, $rootScope, $http, $location, UserServices){
  
  $scope.user = UserServices;

  // watch and emit functions for UserService
  $rootScope.$on('userDetails', function(event, args) {
    //console.log("In watch function header controller, args: ", args);
    $scope.user = args;
  });
  
  $scope.userSignIn = function() {
    $scope.user.signIn($scope.signinEmail, $scope.signinPassword);
  }
  $scope.userSignUp = function() {
    UserServices.signUp($scope.signupEmail, $scope.signupUsername, $scope.signupPassword);
  }
  $scope.userSignOut = function(){
    UserServices.signOut();
  }


}])
