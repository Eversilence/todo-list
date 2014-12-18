@mainApp.controller 'ProjectsController', ['$scope', 'Project'
($scope, Project) ->

  getProjects = ()->
    $scope.projects = Project.index()

  $scope.addProject = ()->
    Project.create(project: {name: $scope.name} ).$promise.then(
      (value)->
        toastr.success('New project successfuly added')
        getProjects()
        $scope.showProjectCreateForm = false
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

  $scope.updateProject = (id, name)->
    Project.update(id: id, project: {id: id, name: name}).$promise.then(
      (value)->
        toastr.success('Project name successfuly changed')
        getProjects()
        $scope.projectName = ''
      ,
      (error)->
        toastr.error('Error changing project name. Try again later')
      )

  getProjects()

]
