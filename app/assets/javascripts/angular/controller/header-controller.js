app.controller('HeaderCtrl', ['$scope', '$http', '$routeParams', function($scope, $http, $routeParams){
  
  $scope.image = {
    'background-image': "url(" + "<%= asset_path('minion.jpg') %>" + ")"
  };

  $http.get('/categories.json').success(function(data){
    // I just found out this is not being called... 
    // do we need it here?
    console.log('*** sucess on get categories');
    console.log("in header ctrl routeparams ", $routeParams);
    // console.log(data);
    $scope.categories = data.categories;
  })

  url = '/';
  params = "";
  $http.get(url, params).success(function(response) {
    console.log("getting new list of pins");
    $scope.pins = response.pins
  })


}])