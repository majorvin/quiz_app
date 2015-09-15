angular.module('quizzer').controller('UserController', UserController);

function UserController($scope, $window, userService, userInitializer) {
  $scope.user = userInitializer;
  initialize();

  $scope.submit = function() {
    userService.updateUser($scope.user)
      .then(function(response) {
        $window.location.href = "/users";
      });
  }

  function initialize(){
    if ($scope.user.deleted_at !== null) {
      $scope.user.deleted_at = true;
    }
  };
};