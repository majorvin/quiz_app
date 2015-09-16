angular.module('quizzer').controller('QuestionController', QuestionController);


function QuestionController($scope, $modalInstance, $window, categoryId, question, questionService) {
  preFillForm();

  var choiceCounter = 2;

  $scope.categoryId = categoryId;
  $scope.errors = [];
  $scope.showError = false;

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
        category_id: $scope.categoryId,
        choices_attributes: $scope.choices
      }
    };

    if (angular.isUndefined(question)) {
      create(params)
    } else {
      params.question.id = question.id;
      update(params);
    }
  };

  $scope.setAnswer = function(choice) {
    angular.forEach($scope.choices, function(c) {
        c.answer = false; //set them all to false
    });

    choice.answer = true; //set the clicked one to true
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };

  function preFillForm() {
    if (angular.isDefined(question)) {

      $scope.title = "Update Question";
      $scope.text =  question.text;
      $scope.choices = question.choices;

      // Set the radio box to be selected
      angular.forEach($scope.choices, function(c) {
        if (c.answer === true) {
          $scope.selectedChoice = c;
        }
      });

    }
    else {
      $scope.title = "Create Question";
      $scope.choices = [
        { text: "", answer: true },
        { text: "", answer: false }
      ];
      $scope.selectedChoice = $scope.choices[0];
    }
  };

  function create(params) {
    questionService.createQuestion(params)
      .then(function() {
        $modalInstance.close("ok");
        $window.location.reload();
      }, function(response) {
        $scope.showError = true;
        $scope.errors = response.data.errors;
      });
  };

  function update(params) {
    questionService.updateQuestion(question.id, params)
      .then(function() {
        $modalInstance.close("ok");
        $window.location.reload();
      }, function(response) {
        $scope.showError = true;
        $scope.errors = response.data.errors;
      });
  };
};