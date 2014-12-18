@mainApp.controller 'TasksController', ['$scope', 'Task'
($scope, Task) ->

  $scope.getTasks = (project_id) ->
    $scope.tasks = Task.index(project_id: project_id)

  $scope.addTask = (project_id) ->
    Task.create(project_id: project_id, task: {name: $scope.taskName} ).$promise.then(
      (value)->
        toastr.success('New task successfuly added')
        $scope.getTasks(project_id)
        $scope.taskName = ''
      ,
      (error)->
        toastr.error('Error adding new task. Try again later')
      )

  $scope.updateTask = (project_id, id) ->
    # not implemented yet

  $scope.deleteTask = (project_id, id) ->
    Task.destroy(project_id: project_id, id: id).$promise.then(
      (value)->
        toastr.success('New task successfuly added')
        $scope.getTasks(project_id)
        $scope.taskName = ''
      ,
      (error)->
        toastr.error('Error adding new task. Try again later')
      )

]
