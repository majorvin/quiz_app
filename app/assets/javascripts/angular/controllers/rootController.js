angular.module("quizzer").controller("RootController", RootController);

function RootController($scope) {
  $scope.onlyNumbers = /^\d+$/;

  $scope.fieldIsValid = function(element) {
    return element.$invalid && !element.$pristine;
  };
};