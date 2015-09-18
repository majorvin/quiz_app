angular.module('quizzer').controller('UserResultController', UserResultController);

function UserResultController($scope, $window, userService, userInitializer) {
  $scope.user = userInitializer;
  $scope.exams = [];
  initialize();

  $scope.showGrade = function(exam) {
    if ( exam.grade === null) { return; }

    return exam.grade + "%";
  };

  $scope.examPassed = function(exam) {
    return exam.grade >= 90;
  };

  function initialize(){
    userService.getResults($scope.user.id)
      .then(function(response) {
        $scope.exams = response.data;
      });
  };
};