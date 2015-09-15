angular.module("quizzer").controller("CategoryListController", CategoryListController);


function CategoryListController($scope, categoryService) {
  initialize();
  $scope.categories = [];
  $scope.currentPage = 1;
  $scope.numPerPage = 25;
  $scope.maxSize = 5;

  $scope.search = function() {
    $scope.currentPage = 1;
    $scope.pageChanged();
  };

  // Display the number in the pagination
  // e.g. Showing X to 100
  $scope.showFrom = function () {
    var number = 0;

    if ($scope.categories.length > 0) {
      number = ($scope.currentPage * $scope.numPerPage) - $scope.numPerPage + 1
    }

    return number;
  };

  // Display the number in the pagination
  // e.g. Showing 1 to Y
  $scope.showTo = function() {
    var number = $scope.currentPage * $scope.numPerPage;

    if ($scope.categories.length < $scope.numPerPage) {
      number = $scope.categories.length;
    }

    return number;
  };

  $scope.pageChanged = function () {
    params = {
      page: $scope.currentPage - 1, // offset
      page_size: $scope.numPerPage,
      keywords: $scope.searchTerm
    };

    categoryService.getAllCategories(params)
      .then(function(response) {
        $scope.categories = response.data.categories;
        $scope.totalItems = response.data.meta.total_count;
    });
  };

  function initialize() {
    categoryService.getAllCategories()
      .then(function(response) {
        $scope.categories = response.data.categories;
        $scope.totalItems = response.data.meta.total_count;
    });
  };
};