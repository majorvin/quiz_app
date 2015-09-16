angular.module("quizzer").controller("CategoryController", CategoryController);


function CategoryController($scope, $window, $modal, categoryService) {
  $scope.category = {};
  $scope.onlyNumbers = /^\d+$/;

  $scope.init = function(id) {
    categoryService.getCategory(id)
      .then(function(response) {
        $scope.category = response.data.category;
        $scope.questions = $scope.category.questions;
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
};