angular.module("quizzer").factory("categoryService", categoryService);

categoryService.$inject = ["$http"];

function categoryService($http) {
  return {
    getAllCategories: function(params) {
      return $http.get("/question_set/categories.json", { params: params });
    },

    getAvailableCategories: function(params) {
      return $http.get("/available.json", { params: params });
    },

    getCategory: function(id) {
      return $http.get("/question_set/categories/" + id + ".json");
    },

    createCategory: function(params) {
      return $http.post("/question_set/categories.json", params);
    },

    updateCategory: function(params) {
      return $http.put("/question_set/categories/" + params.category.id + ".json", params);
    },

    archiveCategory: function(id) {
      return $http.put("/question_set/categories/" + id + "/archive.json");
    },
  };
};