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

  $scope.updateTask = (project_id, id, deadline) ->
    Task.update(project_id: project_id, id:id, task: {deadline: deadline} ).$promise.then(
      (value)->
        toastr.success('Task deadline was successfuly changed')
      ,
      (error)->
        toastr.error('Error changing deadline. Try again later')
      )

  $scope.deleteTask = (project_id, id, index) ->
    Task.destroy(project_id: project_id, id: id).$promise.then(
      (value)->
        toastr.success('Task was successfuly deleted')
        $scope.tasks.splice(index, 1)
      ,
      (error)->
        toastr.error('Error deleting task. Try again later')
      )

  $scope.taskMarkComplete = (project_id, id, completed) ->
    Task.update(project_id: project_id, id: id, task: {completed: completed} ).$promise.then(
      (value)->
        toastr.success('Task was successfuly marked as completed') if isCompleted = true
        toastr.success('Task was successfuly marked as not completed') if isCompleted = false
      ,
      (error)->
        toastr.error('Error marking task complete/incomplete. Try again later')
      )
]
