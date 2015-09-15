angular.module("quizzer").controller("CategoryController", CategoryController);


function CategoryController($scope, categoryService) {
  $scope.onlyNumbers = /^\d+$/;

  $scope.submitCategory = function(invalid) {
    if (invalid) { return; };

    params = {
      category: {
        name: $scope.name,
        enabled: $scope.enabled,
        max_question: $scope.max_question
      }
    };

    // angular.isUndefined(category) ? createCategory(params) : updateCategory(params);
    createCategory(params);

  };

  function createCategory(params) {
    categoryService.createCategory(params)
      .then(function(response) {

      }, function(response) {
      });
  };
};