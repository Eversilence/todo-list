@mainApp.controller 'CommentsController', ['$scope', 'Comment', 'FileUploader'
($scope, Comment, FileUploader) ->

  $scope.selectedComment = { index: -1 }

  $scope.uploader = new FileUploader(url: '', removeAfterUpload: true)
  $scope.uploader.onCompleteAll = (progress) ->
    $scope.getComments()

  $scope.getComments = () ->
    $scope.comments = Comment.index(task_id: $scope.currentTask.id)

  $scope.addComment = (task_id, commentBody) ->
    Comment.create(task_id: task_id, comment: {body: commentBody} ).$promise.then(
      (value)->
        toastr.success('New comment successfuly added')
        $scope.body = ''
        $scope.comments.push(value)
        for item in $scope.uploader.queue
          item.url = '/api/comments/'+value.id+'/attachments'

        $scope.uploader.uploadAll()
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
