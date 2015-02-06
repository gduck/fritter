app.factory('UserServices', ['$http', '$rootScope', '$location', function($http, $rootScope, $location) {
  var user = {};

  user.signedIn = false;
  user.id = "";
  user.name = "Temporary Name";
  user.email = "";
  user.username = "";
  user.userprofile = "";
  user.viewUser = false;
  user.openUser = false;

  user.watchUser = function() {
    $rootScope.$emit('userDetails', user);
  }

  user.signIn = function(email, password) {

    var url = "/users/sign_in";
    var data = {
      'user': {
        'email': email,
        'password': password,
        'password_confirmation': password
      },
      'commit': "Sign In"
    };
    $http.post(url, data).success(function(response, status, xhr){
      user.signedIn = response.success;
      user.id = response.id;
      user.username = response.username;
      user.userprofile = response.userprofile;
      user.email = response.email;
      user.watchUser();
    }).error(function(response) {
      console.log("problem!! - ",response);
      user.signedIn = false;
    });
    user.openUser = false;
  };  

  user.signUp = function(email, username, password) {
    var url = "/users";
    var data = {
      'user': {
        'email': email,
        'username': username,
        'password': password,
        'password_confirmation': password
      },
      'commit': "Sign Up"
    };
    $http.post(url, data).success(function(response, status, xhr){
      user.signedIn = response.success;
      user.id = response.id;
      user.username = response.username;
      user.userprofile = response.userprofile;
      user.email = response.email;
      user.watchUser();      
    }).error(function(response) {
      console.log("problem!! - " + response);
      user.signedIn = false;
    });
    user.openUser = false;
  }

 user.signOut = function(){
    user.openUser = false;
    $http.delete("/users/sign_out.json").success(function(response,status){
      console.log(response);
      user.signedIn = false;
      user.id = null;
      user.username = "";
      user.userprofile = "";
      user.email = "";
      user.openUser = false;
      user.watchUser();            
      $location.path("/");
    }).error(function(response,status){
      console.log("ERROR in signout");
      console.log(response);
      console.log(status);
    });
  };

  return user;
}]);

