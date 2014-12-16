@mainApp.controller 'ProjectsController', ['$scope', 'Project', '$http'
($scope, Project, $http) ->

  getProjects = ()->
    $scope.projects = Project.index()

  $scope.addProject = ()->
    Project.create(project: {name: $scope.name} ).$promise.then(
      (value)->
        toastr.success('New project successfuly added')
        getProjects()
        $scope.showForm = false
        $scope.name = ''
      ,
      (error)->
        toastr.error('Error adding new project. Try again later')
      )

  $scope.deleteProject = (id)->
    Project.destroy(id: id).$promise.then(
      (value)->
        toastr.success('Project successfuly deleted')
        getProjects()
      ,
      (error)->
        toastr.error('Error deleting project. Try again later')
      )

  getProjects()

]
