angular.module("quizzer").controller("ExamResultController", ExamResultController);

function ExamResultController($scope, $window, categoryService) {
  $scope.exams = [];

  $scope.init = function(categoryId) {

    categoryService.getResult(categoryId)
      .then(function(response) {
        $scope.exams = response.data;
      }, function(response) {
        console.log("Something went wrong.");
      });
  };

  $scope.showGrade = function(category) {
    if (category.grade === null) { return; }

    return category.grade + "%";
  };

  $scope.examPassed = function(category) {
    return category.grade >= 90;
  };
};