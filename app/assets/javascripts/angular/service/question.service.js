angular.module("quizzer").factory("questionService", questionservice);

questionservice.$inject = ["$http"];

function questionservice($http) {
  return {
    getCategoryQuestions: function(params) {
      return $http.get("/question_set/questions.json", { params: params });
    },

    getQuestion: function(id) {
      return $http.get("/question_set/questions/" + id + ".json");
    },

    createQuestion: function(params) {
      return $http.post("/question_set/questions.json", params);
    },

    updateQuestion: function(question) {
      return $http.put("/question_set/questions/" + params.question.id + ".json", params);
    },

    archiveQuestion: function(id) {
      return $http.put("/question_set/questions/" + id + "/archive.json");
    }
  };
};