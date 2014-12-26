@mainApp.controller 'AttachmentsController', ['$scope', 'Attachment', 'FileUploader'
($scope, Attachment, FileUploader) ->

  $scope.singleUploader = new FileUploader(url: '', removeAfterUpload: true, autoUpload: true)

  $scope.singleUploader.onBeforeUploadItem = () ->
    $scope.singleUploader.queue[0].url = '/api/comments/'+$scope.comment.id+'/attachments'

  $scope.singleUploader.onSuccessItem = (item, response, status, headers) ->
    $scope.attachments.push(response)

  $scope.getAttachments = (comment_id) ->
    $scope.attachments = Attachment.index(comment_id: comment_id)

  $scope.deleteAttachment = (comment_id, id, index) ->
    Attachment.destroy(comment_id: comment_id, id: id).$promise.then(
      (value)->
        toastr.success('Attachment was successfuly deleted')
        $scope.attachments.splice(index, 1)
      ,
      (error)->
        toastr.error('Error deleting attachment. Try again later')
      )
]
