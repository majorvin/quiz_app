angular.module("quizzer").factory("userService", userService);

userService.$inject = ["$http"];

function userService($http) {
  return {
    getAllUsers: function(params) {
      return $http.get("/users.json", { params: params });
    },
  };
};