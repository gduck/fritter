app.factory('UserServices', ["$http", function($http){
  var user = {};

  user.logInStatus = false;

  return user;
}]);