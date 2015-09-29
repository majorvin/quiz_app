angular.module("quizzer").controller("CategoryController", CategoryController);


function CategoryController($scope) {
  $scope.category = {};

  $scope.init = function(category) {
    $scope.category = JSON.parse(category);
  };
};