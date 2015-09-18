angular.module("quizzer").factory("userService", userService);

userService.$inject = ["$http"];

function userService($http) {
  return {
    getAllUsers: function(params) {
      return $http.get("/users.json", { params: params });
    },

    updateUser: function(params) {
      return $http.put("/users/" + params.id + ".json", params);
    },

    getResults: function(id) {
      return $http.get("/users/" + id + "/results.json");
    }
  };
};