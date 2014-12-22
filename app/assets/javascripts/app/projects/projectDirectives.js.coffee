angular.module("todo")
  .directive "projectDirective", ->
    replace: true,
    trancslude: true,
    templateUrl: 'app/templates/projects/projectTemplate.html'
  .directive "projectCreateForm", ->
    trancslude: true,
    templateUrl: 'app/templates/projects/projectCreateFormTemplate.html'
  .directive "projectUpdateForm", ->
    trancslude: true,
    templateUrl: 'app/templates/projects/projectUpdateFormTemplate.html'
