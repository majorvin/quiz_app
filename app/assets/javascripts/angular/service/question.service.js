angular.module("quizzer").factory("questionService", questionservice);

questionservice.$inject = ["$http"];

function questionservice($http) {
  return {
    getCategoryQuestions: function(params) {
      return $http.get("/question_set/questions.json", { params: params });
    },

    createQuestion: function(params) {
      return $http.post("/question_set/questions.json", params);
    },
  };
};