angular.module("quizzer").factory("usersService", usersService);

usersService.$inject = ["$http"];

function usersService($http) {
  return {
    getAllUsers: function(params) {
      return $http.get("/users.json", { params: params });
    },
  };
};