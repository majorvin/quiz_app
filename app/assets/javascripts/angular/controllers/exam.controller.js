angular.module("quizzer").controller("ExamController", ExamController);


function ExamController($scope, $window, Flash, examListService, examQuestionService) {
  var ratio = 0;
  $scope.trackProgress = 0;
  $scope.progress = "0%";
  $scope.questions = [];
  $scope.displayedQuestion = null;
  $scope.currentPage = 1;
  $scope.totalItems = 0;
  $scope.examTitle = null;

  $scope.init = function(id) {
    examListService.getExam(id)
      .then(function(response) {
        $scope.examTitle = response.data.list.name;
        $scope.questions = response.data.list.questions;
        $scope.totalItems = $scope.questions.length;
        $scope.displayedQuestion = $scope.questions[$scope.currentPage - 1];
        ratio = 1 / $scope.totalItems * 100;
        setQuestionAnswer();

        if (response.data.list.workflow_state === "in_progress") {
          var message = "<strong>Welcome Back!</strong> Let us continue your exam.";
          Flash.create('info', message, 'custom-class');
        }

        // Mark the loading bar
        angular.forEach($scope.questions, function(q) {
          if (q.value !== null) {
            $scope.trackProgress += ratio;
            $scope.progress = $scope.trackProgress + "%";
          }
        });
      });
  };

  $scope.pageChanged = function() {
    $scope.displayedQuestion = $scope.questions[$scope.currentPage - 1];

    setQuestionAnswer();
  };

  $scope.setAnswer = function(choice) {
    if ($scope.displayedQuestion.value === null) { $scope.trackProgress += ratio; };

    $scope.displayedQuestion.value = choice.id;
    $scope.progress = $scope.trackProgress + "%";

    params = {
      question: {
        id: $scope.displayedQuestion.id,
        value: $scope.displayedQuestion.value
      }
    }

    examQuestionService.answerQuestion(params)
      .then(function(response) {

      }, function(response) {
        console.log("Something went wrong");
      });
  };

  $scope.showSubmitBtn = function() {
    return $scope.trackProgress >= 100;
  };

  function setQuestionAnswer() {
    // Set the radio box to be selected
    var value = $scope.displayedQuestion.value;

    if (value !== null || value !== undefined) {
      angular.forEach($scope.displayedQuestion.choices, function(c) {
        // compare integer and string
        if (c.id == value) {
          $scope.selectedChoice = c;
        }
      });
    }
  };
};