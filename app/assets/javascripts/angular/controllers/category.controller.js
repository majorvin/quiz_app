angular.module("quizzer").controller("CategoryController", CategoryController);


function CategoryController($scope, $window, $modal, categoryService, questionService) {
  $scope.category = {};
  $scope.questions = [];
  $scope.onlyNumbers = /^\d+$/;
  $scope.currentPage = 1;
  $scope.maxSize = 5;
  $scope.numPerPage = 25;

  $scope.init = function(id) {
    categoryService.getCategory(id)
      .then(function(response) {
        $scope.category = response.data.category;
    });

    questionService.getCategoryQuestions({category_id: id})
      .then(function(response) {
        $scope.questions = response.data.questions;
        $scope.totalItems = response.data.meta.total_count;
    });
  };

  $scope.submitQuestion = function (questionId) {
    var modalInstance = $modal.open({
      animation: true,
      templateUrl: 'question-form.html',
      controller: 'QuestionController',
      size: 'lg',
      resolve: {
        categoryId: function() {
          return $scope.category.id;
        },
        question: function(questionService) {
          if (angular.isDefined(questionId)) {
            return questionService.getQuestion(questionId)
              .then(function(response) {
                return response.data.question
              });
          }
          else {
            undefined;
          }
        }
      }
    });
  };

  $scope.submitCategory = function(invalid) {
    if (invalid) { return; };

    params = {
      category: $scope.category
    };

    $window.location.pathname.includes("/edit") ? updateCategory(params) : createCategory(params)
  };

  function createCategory(params) {
    categoryService.createCategory(params)
      .then(function(response) {
        $window.location.href = "/question_set/categories/" + response.data.id + "/edit/";
      });
  };

  function updateCategory(params) {
    categoryService.updateCategory(params)
      .then(function(response) {
        $window.location.reload();
      });
  };

  $scope.archiveQuestion = function(id) {
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
      questionService.archiveQuestion(id)
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

  // Display the number in the pagination
  // e.g. Showing X to 100
  $scope.showFrom = function () {
    var number = 0;

    if ($scope.questions.length > 0) {
      number = ($scope.currentPage * $scope.numPerPage) - $scope.numPerPage + 1
    }

    return number;
  };

  // Display the number in the pagination
  // e.g. Showing 1 to Y
  $scope.showTo = function() {
    var number = $scope.currentPage * $scope.numPerPage;
    var totalPages = $scope.totalItems / $scope.numPerPage;

    if (Math.ceil(totalPages) === $scope.currentPage ) {
      number = $scope.totalItems;
    }

    return number;
  };

  $scope.pageChanged = function() {
    params = {
      page: $scope.currentPage - 1, // offset
      page_size: $scope.numPerPage,
      keywords: $scope.searchTerm,
      category_id: $scope.category.id
    };

    questionService.getCategoryQuestions(params)
      .then(function(response) {
        $scope.questions = response.data.questions;
        $scope.totalItems = response.data.meta.total_count;
    });
  };

  $scope.search = function(searchTerm) {
    $scope.currentPage = 1;
    $scope.pageChanged();
  };
};