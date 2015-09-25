angular.module("quizzer").factory("examListService", examListService);

examListService.$inject = ["$http"];

function examListService($http) {
  return {
    createExam: function(params) {
      return $http.post("/exam/list.json", params);
    },

    //this will find or create an exam and returns id
    findExam: function(params) {
      return $http.get("/exam/lists/find.json", { params: params });
    },

    getExam: function(id) {
      return $http.get("/exam/lists/" + id + ".json");
    },

    completeExam: function(id) {
      return $http.put("/exam/lists/" + id + ".json");
    }
  };
};