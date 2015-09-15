angular.module("quizzer").controller("CategoryController", CategoryController);


function CategoryController($scope, $window, categoryService) {
  $scope.category = {};
  $scope.onlyNumbers = /^\d+$/;

  $scope.init = function(id, name, enabled, max_question) {
    $scope.category = {
      id: id,
      name: name,
      enabled: enabled === "true" ? true : false,
      max_question: max_question
    }
  };

  $scope.submitCategory = function(invalid) {
    if (invalid) { return; };

    params = {
      category: $scope.category
    };

    $window.location.pathname.includes("/edit/") ? updateCategory(params) : createCategory(params)
  };

  function createCategory(params) {
    categoryService.createCategory(params)
      .then(function(response) {
        $window.location.href = "/question_set/categories/" + response.data.id + "/edit/";
      });
  };

  function updateCategory(params) {
    categoryService.updateCategory(params)
      .then(function(response) {
        $window.location.reload();
      });
  };
};