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
  $scope.list = null;
  $scope.examCompleted = false;

  $scope.init = function(id) {
    examListService.getExam(id)
      .then(function(response) {
        $scope.list = response.data.list;
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
        else if (response.data.list.workflow_state === "completed") {
          $scope.examCompleted = true;
          var message = "<strong>Welcome Back!</strong> This exam has been completed and can no longer be modified.";
          Flash.create('success', message, 'custom-class');
        };

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

  $scope.showQuestionResult = function(question) {
    return question.value ? "Answered" : "Not Answered";
  };

  $scope.showSubmitBtn = function() {
    return $scope.trackProgress.toFixed(2) >= 100 && !$scope.examCompleted;
  };

  $scope.submit = function() {
    if ($scope.examCompleted) { return; }

    examListService.completeExam($scope.list.id)
      .then(function(response) {

      });
  };

  $scope.goTo = function(index) {
    $scope.currentPage = index + 1;
    $scope.displayedQuestion = $scope.questions[index]
  };

  function setQuestionAnswer() {
    // Set the radio box to be selected
    var value = $scope.displayedQuestion.value;

    if (value !== null) {
      angular.forEach($scope.displayedQuestion.choices, function(c) {
        // compare integer and string
        if (c.id == value) {
          $scope.selectedChoice = c;
        }
      });
    }
  };
};