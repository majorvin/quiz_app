angular.module("quizzer").controller("AvailableController", AvailableController);


function AvailableController($scope, $window, categoryService, examListService) {
  initialize();

  $scope.categories = [];

  $scope.start = function(category) {
    var params = { category_id: category.id };
    var examId = 0;

    examListService.findExam(params)
      .then(function(response) {
        $window.location.href = response.data.url
      }, function() {
        console.log("Something happened!")
      })
  };

  $scope.showGrade = function(category) {
    if (category.last_grade === null) { return; }

    return category.last_grade + "%";
  };

  $scope.examPassed = function(category) {
    return category.last_grade >= 90;
  };

  function initialize() {
    categoryService.getAvailableCategories()
      .then(function(response) {
        $scope.categories = response.data.categories;

      }, function() {

      });
  };
};