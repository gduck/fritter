app.factory('UserServices', function() {
  var user = {};

  user.signedIn = false;
  user.name = "Temporary Name";
  user.email = "";
  user.username = "";

  return user;
});

