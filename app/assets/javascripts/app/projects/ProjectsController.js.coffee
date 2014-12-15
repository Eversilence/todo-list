@mainApp.controller 'ProjectsController', ['$scope', 'Projects', '$http'
($scope, Projects, $http) ->
#

  getProjects = ()->
    $scope.projects = Projects.query()

  $scope.addProject = ()->
    request = $http
      method: "post",
      url: "/api/projects"
      data: { project: {name: $scope.name} }

    request.success () ->
      toastr.success('New project successfuly added')
      getProjects()
      $scope.name = ''

    request.error () ->
      toastr.error('Error adding new project. Try again later')

  $scope.deleteProject = (id)->
    console.log (id)
    request = $http
      method: "post",
      url: "/api/projects/destroy"
      data: { project: {id: id} }

    request.success () ->
      toastr.success('Project successfuly deleted')
      getProjects()

    request.error () ->
      toastr.error('Error deleting new project. Try again later')

  $scope.test = (string)->
    alert(string)


  getProjects()

]
