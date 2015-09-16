angular.module("quizzer").controller("CategoryListController", CategoryListController);


function CategoryListController($scope, $window, categoryService) {
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

  $scope.archiveCategory = function(id) {
    swal({
      title: "Are you sure?",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, delete it!",
      closeOnConfirm: false,
      allowOutsideClick: true
    },
    function() {
      categoryService.archiveCategory(id)
        .then(function() {
          $window.location.reload();
        }, function(response) {
          swal({
            title: "Oops...",
            text: "Something went wrong!",
            type: "error",
            allowOutsideClick: true
          });
      });
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