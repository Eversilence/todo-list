@mainApp.controller 'CommentsController', ['$scope', 'Comment'
($scope, Comment) ->

  $scope.getComments = (task_id) ->
    console.log ($scope.currentTask)
    console.log ('task_id: '+$scope.currentTask.id+', project_id: '+$scope.currentTask.project_id)
    $scope.comments = Comment.index(task_id: $scope.currentTask.id)
    console.log ($scope.comments)

  $scope.addComment = (task_id) ->
    Comment.create(task_id: task_id, comment: {body: $scope.commentBody} ).$promise.then(
      (value)->
        toastr.success('New comment successfuly added')
        $scope.getComments(task_id)
        $scope.commentBody = ''
      ,
      (error)->
        toastr.error('Error adding new task. Try again later')
      )

  $scope.deleteComment = (task_id, id, index) ->
    Comment.destroy(task_id: task_id, id: id).$promise.then(
      (value)->
        toastr.success('Comment was successfuly deleted')
        $scope.comments.splice(index, 1)
      ,
      (error)->
        toastr.error('Error deleting comment. Try again later')
      )

  $scope.updateComment = (task_id, id) ->
    Comment.update(task_id, id, comment: {body: $scope.commentBody} ).$promise.then(
      (value)->
        toastr.success('Comment was successfuly updated')
      ,
      (error)->
        toastr.error('Error updating comment. Try again later')
      )
]
