angular.module("todo")
  .directive "taskDirective", ->
    scope: true,
    replace: true,
    transclude: true,
    templateUrl: 'app/templates/tasks/taskTemplate.html'
