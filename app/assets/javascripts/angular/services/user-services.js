app.factory('UserServices', function() {
  var user = {};

  user.signedIn = false;
  user.email = "";
  user.username = "";

  return user;
});

