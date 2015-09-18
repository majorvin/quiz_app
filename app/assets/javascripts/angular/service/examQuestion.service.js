angular.module("quizzer").factory("examQuestionService", examQuestionService);

examQuestionService.$inject = ["$http"];

function examQuestionService($http) {
  return {
    answerQuestion: function(params) {
      return $http.put("/exam/questions/" + params.question.id + ".json", params);
    },
  };
};