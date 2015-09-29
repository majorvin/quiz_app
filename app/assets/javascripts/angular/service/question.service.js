angular.module("quizzer").factory("questionService", questionservice);

questionservice.$inject = ["$http"];

function questionservice($http) {
  return {
    getQuestion: function(categoryId, questionId) {
      return $http.get("/question_set/categories/" + categoryId + "/questions/" + questionId + ".json");
    },

    createQuestion: function(params) {
      return $http.post("/question_set/categories/" + params.question.category_id + "/questions", params);
    },

    updateQuestion: function(question) {
      return $http.put("/question_set/categories/" + params.question.category_id + "/questions/" + params.question.id + ".json", params);
    },
  };
};