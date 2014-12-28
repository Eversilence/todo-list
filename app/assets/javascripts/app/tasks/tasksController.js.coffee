@mainApp.controller 'TasksController', ['$scope', '$modal', 'Task'
($scope, $modal, Task) ->

  $scope.selectedTask = { index: -1 }


  $scope.getTasks = (project_id) ->
    $scope.tasks = Task.index(project_id: project_id)

  $scope.addTask = (project_id) ->
    Task.create(project_id: project_id, task: {name: $scope.taskName} ).$promise.then(
      (value)->
        toastr.success('New task successfuly added')
        $scope.taskName = ''
        $scope.tasks.push(value)
      ,
      (error)->
        toastr.error('Error adding new task. Try again later')
      )

  $scope.updateTaskDeadline = (project_id, id, deadline) ->
    Task.update(project_id: project_id, id:id, task: {deadline: deadline} ).$promise.then(
      (value)->
        toastr.success('Task deadline was successfuly changed')
      ,
      (error)->
        toastr.error('Error changing deadline. Try again later')
      )

  $scope.updateTaskName = (project_id, id, name) ->
    Task.update(project_id: project_id, id:id, task: {name: name} ).$promise.then(
      (value)->
        toastr.success('Task name was successfuly changed')
        $scope.selectedTask.index = -1
      ,
      (error)->
        toastr.error('Error changing task name. Try again later')
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
        toastr.success('Task was successfuly marked as completed') if completed == true
        toastr.success('Task was successfuly marked as incomplete') if completed == false
      ,
      (error)->
        toastr.error('Error marking task complete/incomplete. Try again later')
      )

  $scope.showCommentModal = (task, index) ->
    $scope.currentTask = $scope.tasks[index]
    my_modal = $modal({title: task.name, scope: $scope, template: 'app/templates/tasks/taskCommentsModalTemplate.html', show: true})

  initDragDrop = () ->
    $scope.$callbacks.accept = (sourceNodeScope, destNodesScope, destIndex) ->
     console.log(destIndex)
     return true

]
