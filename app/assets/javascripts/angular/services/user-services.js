app.factory('UserServices', ['$http', '$rootScope', function($http, $rootScope) {
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
    console.log("in userservice function");
    console.log("email password :", email, password);
    var url = "/users/sign_in";
    var data = {
      'user': {
        'email': email,
        'password': password,
        'password_confirmation': password
      },
      'commit': "Sign In"
    };
    console.log("DATA: ", data);
    $http.post(url, data).success(function(response, status, xhr){
      console.log("SUCCESSFUL signin response ", response);
      
      user.signedIn = response.success;
      user.id = response.id;
      user.username = response.username;
      user.userprofile = response.userprofile;
      user.email = response.email;
      user.watchUser();
      // console.log('this (after signedIn) p', this.parent);
      console.log('this (after signedIn) u', user);
      // console.log('this (after signedIn) tpp', this.parent.parent);
    }).error(function(response) {
      console.log("problem!! - " + response);
      user.signedIn = false;
    });
    user.openUser = false;
  };  


  return user;
}]);

