app.factory('UserServices', function() {
  var user = {};

  user.signedIn = false;
  user.id = "";
  user.name = "Temporary Name";
  user.email = "";
  user.username = "";
  user.viewUser = true;

  return user;
});

