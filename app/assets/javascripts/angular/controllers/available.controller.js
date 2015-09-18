angular.module("quizzer").controller("AvailableController", AvailableController);


function AvailableController($scope, $window, categoryService, examListService) {
  initialize();

  $scope.categories = [];

  $scope.start = function(categoryId) {
    var params = { category_id: categoryId };
    var examId = 0;

    examListService.findExam(params)
      .then(function(response) {
        $window.location.href = response.data.url
      }, function() {
        console.log("Something happened!")
      })
  };

  function initialize() {
    categoryService.getAvailableCategories()
      .then(function(response) {
        $scope.categories = response.data.categories;

      }, function() {

      });
  };
};