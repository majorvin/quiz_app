angular.module('quizzer').controller('UsersController', UsersController);

function UsersController($scope, usersService) {
  initialize();
  $scope.users = [];
  $scope.currentPage = 1;
  $scope.numPerPage = 10;
  $scope.maxSize = 5;
  $scope.totalItems = 0;

  $scope.search = function() {
    $scope.currentPage = 1;
    $scope.pageChanged();
  };

  // Display the number in the pagination
  // e.g. Showing X to 100
  $scope.showFrom = function () {
    var number = 0;

    if ($scope.users.length > 0) {
      number = ($scope.currentPage * $scope.numPerPage) - $scope.numPerPage + 1
    }

    return number;
  };

  // Display the number in the pagination
  // e.g. Showing 1 to Y
  $scope.showTo = function() {
    var number = $scope.currentPage * $scope.numPerPage;

    if ($scope.users.length < $scope.numPerPage) {
      number = $scope.users.length;
    }

    return number;
  };

  $scope.pageChanged = function () {
    params = {
      page: $scope.currentPage - 1, // offset
      page_size: $scope.numPerPage,
      keywords: $scope.searchTerm
    };

    usersService.getAllUsers(params)
      .then(function(response) {
        $scope.users = response.data.users;
        $scope.totalItems = response.data.meta.total_count;
    });
  };

  function initialize() {
    usersService.getAllUsers()
      .then(function(response) {
        $scope.users = response.data.users;
        $scope.totalItems = response.data.meta.total_count;
    });
  };
};