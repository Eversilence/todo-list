angular.module("todo")
  .directive "projectDirective", ->
    replace: true,
    transclude: true,
    templateUrl: 'app/templates/projects/projectTemplate.html'
  .directive "projectCreateForm", ->
    transclude: true,
    templateUrl: 'app/templates/projects/projectCreateFormTemplate.html'
  .directive "projectUpdateForm", ->
    transclude: true,
    templateUrl: 'app/templates/projects/projectUpdateFormTemplate.html'
