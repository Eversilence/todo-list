@mainApp.factory 'Attachment',
['$resource', ($resource) ->
  $resource "/api/comments/:comment_id/attachments/:id",{ comment_id: "@task_id", id: "@id" },
  {
    create:
      method: "POST"

    index:
      method: "GET"
      isArray: true

    show:
      method: "GET"
      isArray: false

    update:
      method: "PUT"

    destroy:
      method: "DELETE"
  }
]
