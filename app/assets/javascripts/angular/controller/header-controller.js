app.controller('HeaderCtrl', ['$scope', '$http', 
  function($scope, $http){
  
  $scope.image = {
    'background-image': "url(" + "<%= asset_path('minion.jpg') %>" + ")"
  };

  $http.get('/categories.json').success(function(data){
    console.log('sucess on get categories');
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