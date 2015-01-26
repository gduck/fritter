app.controller('HeaderCtrl', ['$scope', '$http', 
  function($scope, $http){
  
  $scope.image = {
    'background-image': "url(" + "<%= asset_path('minion.jpg') %>" + ")"

  };

  $http.get('/categories.json').success(function(data){
    console.log('sucess on get categories');
    console.log(data);
    console.log(data.categories[0].name);
    $scope.categories = data.categories;
  })



}])