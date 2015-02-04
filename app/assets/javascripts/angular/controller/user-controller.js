app.controller('UserCtrl', ['$scope', '$http', '$location', 'UserServices',
  function($scope, $http, $location, UserServices){

  // if (!UserServices.signedIn) {
  //   console.log("redirecting....");
  //   $location.path('/user/user-account.html');
  // } 

  // UserServices sets the current user data whenever it is changed
  // ie on signin, signup 
  // TODO on edit
  $scope.user = UserServices;

    var limit = 12; // limit = the number of pins each get requests retrieve
    var offset = 0; // the number of times it does loadMore, for inifinity scroll
    var end = false;
    $scope.busy = false;
    $scope.after = '';

  $http.get('pins.json?limit=' + limit + '&offset=' + offset).success(function(data){
    //console.log('success on getting pins from UserCtrl');
    $scope.pins = data.pins;
  })

  $http.get('/categories.json').success(function(data){
    //console.log('success on get categories');
    // console.log(data);
    $scope.categories = data.categories;
  })

    // inifinite scroll function
  $scope.nextPage = function() {
    if ($scope.busy) return;
    if (end == true) return;
    $scope.busy = true;
    offset += limit;
    $http.get('pins.json?limit=' + limit + '&offset=' + offset).success(function(data){
       console.log(offset,'--',data.pins);

       var numPins = data.pins.length;
       if (numPins < limit){
        end = true;
       }
       for(var i = 0; i < numPins; i++) {
        $scope.pins.push(data.pins[i]);
      }
      $scope.busy = false;
    });
  }

  $scope.open = false
  $scope.openPin = function(pin_id){
    console.log(pin_id);
    $http.get('pins/' + pin_id + '.json').success(function(data){
      console.log(data);
      $scope.pin = data.pins[0];
    })
    $scope.open = !$scope.open;
    console.log('click');
  }
  $scope.closePin = function(){
    $scope.open = !$scope.open;
  }
}])
