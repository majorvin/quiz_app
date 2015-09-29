angular.module("quizzer").factory("categoryService", categoryService);

categoryService.$inject = ["$http"];

function categoryService($http) {
  return {
    getAvailableCategories: function(params) {
      return $http.get("/available.json", { params: params });
    },

    getResult: function(id) {
      return $http.get("/question_set/categories/" + id + "/results.json");
    },
  };
};