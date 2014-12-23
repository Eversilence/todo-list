@mainApp.factory 'Comment',
['$resource', ($resource) ->
  $resource "/api/tasks/:task_id/comments/:id",{ task_id: "@task_id", id: "@id" },
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
