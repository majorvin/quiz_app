angular.module("quizzer").factory("categoryService", categoryService);

categoryService.$inject = ["$http"];

function categoryService($http) {
  return {
    getAllCategories: function(params) {
      return $http.get("/question_set/categories.json", { params: params });
    },
  };
};