app.controller('HeaderCtrl', ['$scope', '$http', 
  function($scope, $http){
  
  $scope.image = {
    'background-image': "url(" + "<%= asset_path('minion.jpg') %>" + ")"
  };

  $http.get('/categories.json').success(function(data){
    console.log('success on get categories');
    // console.log(data);
    $scope.categories = data.categories;
  });

  // $scope.getCategoryPins = function(){
  //   $http.get('/pins').success(function(response) {
  //     console.log("we clicked on categories, search param is ");
  //   })
  // }

}])