angular.module("todo")
  .directive "taskDirective", ->
    scope: true,
    replace: true,
    transclude: true,
    templateUrl: 'app/templates/tasks/taskTemplate.html'
  .directive "taskUpdateForm", ->
    transclude: true,
    templateUrl: 'app/templates/tasks/taskUpdateFormTemplate.html'
