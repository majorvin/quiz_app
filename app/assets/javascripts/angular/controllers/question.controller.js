angular.module('quizzer').controller('QuestionController', QuestionController);

function QuestionController($scope, $window, questionService) {
  var choiceCounter = 2;
  var questionId = "";
  var categoryId = "";

  $scope.init = function(cId, qId) {
    categoryId = cId;
    questionId = qId;

    if (questionId === "")
    {
      $scope.choices = [
        { text: "", answer: true },
        { text: "", answer: false }
      ];
      $scope.selectedChoice = $scope.choices[0];

    } else {
      questionService.getQuestion(categoryId, questionId)
        .then(function(response) {
          $scope.text =  response.data.question.text;
          $scope.choices = response.data.question.choices;

          // Set the radio box to be selected
          angular.forEach($scope.choices, function(c) {
            if (c.answer === true) {
              $scope.selectedChoice = c;
            }
          });
        });
    }
  };

  $scope.hideDeletedChoice = function(choice) {
    return !choice._destroy;
  };

  $scope.addChoice = function($event) {
    choiceCounter++;
    $scope.choices.push({
      text: "", answer: false
    })

    $event.preventDefault();
  };

  $scope.removeChoice = function(choice, $event) {
    choice._destroy = "1"

    $event.preventDefault();
  };

  $scope.ok = function (invalid) {
    if (invalid) { return; }

    params = {
      question: {
        text: $scope.text,
        category_id: categoryId,
        choices_attributes: $scope.choices
      }
    };

    if (questionId === "") {
      create(params)
    } else {
      params.question.id = questionId;
      update(params);
    }
  };

  $scope.setAnswer = function(choice) {
    angular.forEach($scope.choices, function(c) {
        c.answer = false; //set them all to false
    });

    choice.answer = true; //set the clicked one to true
  };

  function create(params) {
    questionService.createQuestion(params)
      .then(function() {
        $window.history.back();
        $window.location.reload();
      });
  };

  function update(params) {
    questionService.updateQuestion(params)
      .then(function() {
        $window.history.back();
        $window.location.reload();
      });
  };
};