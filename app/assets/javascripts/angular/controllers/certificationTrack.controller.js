angular.module("quizzer").controller("CertificationTrackController", CertificationTrackController);

function CertificationTrackController($scope) {
  $scope.init = function(name, enabled)
  {
    $scope.track = {
      name: name,
      enabled: enabled
    };
  };

  $scope.fieldIsValid = function(fieldName) {
    return $scope.form[fieldName].$invalid && !$scope.form[fieldName].$pristine;
  };
};