angular.module('quizzer').controller('UserController', UserController);

function UserController($scope, userService, userInitializer) {
  $scope.user = userInitializer;
  initialize();

  $scope.submit = function() {
    userService.updateUser($scope.user)
      .then(function(response) {
        swal({
          title: "Updated!",
          type: "success",
          allowOutsideClick: true
        });
      });
  }

  function initialize(){
    if ($scope.user.deleted_at !== null) {
      $scope.user.deleted_at = true;
    }
  };
};