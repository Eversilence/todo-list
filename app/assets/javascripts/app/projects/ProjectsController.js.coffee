@mainApp.controller 'ProjectsController', ['$scope', 'Project'
($scope, Project) ->


  getProjects = () ->
    $scope.projects = Project.index()

  clearSelectedProject = () ->
    # init object with -1 to avoid collisions when comparing with other values
    $scope.selectedProject = { index: -1 }

  init = () ->
    getProjects()
    clearSelectedProject()

  $scope.addProject = ()->
    Project.create(project: {name: $scope.name} ).$promise.then(
      (value)->
        toastr.success('New project successfuly added')
        $scope.name = ''
        $scope.showProjectCreateForm = false
        getProjects()
      ,
      (error)->
        toastr.error('Error adding new project. Try again later')
      )

  $scope.deleteProject = (id, index)->
    Project.destroy(id: id).$promise.then(
      (value)->
        toastr.success('Project successfuly deleted')
        $scope.projects.splice(index, 1)
      ,
      (error)->
        toastr.error('Error deleting project. Try again later')
      )

  $scope.updateProject = (id, name)->
    Project.update(id: id, project: {id: id, name: name}).$promise.then(
      (value)->
        toastr.success('Project name successfuly changed')
        $scope.selectedProject.index = -1
      ,
      (error)->
        toastr.error('Error changing project name. Try again later')
      )

  init()

]
