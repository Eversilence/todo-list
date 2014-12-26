@mainApp.controller 'AttachmentsController', ['$scope', 'Attachment'
($scope, Attachment) ->

  $scope.getAttachments = (comment_id) ->
    $scope.attachments = Attachment.index(comment_id: comment_id)

  $scope.deleteAttachment = (comment_id, id, index) ->
    console.log (comment_id+' '+id+' '+index)
    Attachment.destroy(comment_id: comment_id, id: id).$promise.then(
      (value)->
        toastr.success('Attachment was successfuly deleted')
        $scope.attachments.splice(index, 1)
      ,
      (error)->
        toastr.error('Error deleting attachment. Try again later')
      )
]
