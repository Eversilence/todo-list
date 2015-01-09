@mainApp.controller 'TasksController', ['$scope', '$modal', 'Task', '$filter'
($scope, $modal, Task, $filter) ->

  $scope.selectedTask = { index: -1 }
  $scope.draggedTask  = { project_id: ''}

  $scope.getTasks = (project_id) ->
    $scope.tasks = Task.index(project_id: project_id).$promise.then(
      (value)->
        $scope.tasks = $filter('orderBy')(value, 'priority_index', false)
      ,
      (error)->
        toastr.error('Failed to fetch tasks from server. Try again later')
      )

  $scope.addTask = (project_id) ->
    if $scope.tasks[0] != undefined
      lastTask = $scope.tasks.length-1
      priority = $scope.tasks[lastTask].priority_index+1
    else
      priority = 0

    Task.create(project_id: project_id, task: {name: $scope.taskName, priority_index: priority} ).$promise.then(
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
        $scope.tasks.splice(index, 1)
        toastr.success('Task was successfuly deleted')
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

  $scope.treeOptions =
    dropped: (event) ->
      if (event.source.index != event.dest.index)
        event.source.nodeScope.task.priority_index = event.dest.index

        i = 0
        for task in event.source.nodeScope.tasks
          task.priority_index = i
          i = i+1
          Task.update(project_id: task.project_id, id:task.id, task: {priority_index: task.priority_index} )

    beforeDrag: (sourceNodeScope) ->
      $scope.draggedTask.project_id = sourceNodeScope.task.project_id
      return true

    accept: (sourceNodeScope, destNodesScope, destIndex) ->
      if destNodesScope.tasks[0].project_id != $scope.draggedTask.project_id
        return false
      else
        return true

]
