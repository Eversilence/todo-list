@mainApp.factory 'Task',
['$resource', ($resource) ->
  $resource "/api/projects/:project_id/tasks/:id", { project_id: "@project_id", id: "@id" },
  {
    create:
      method: "POST"

    index:
      method: "GET"
      url: "/api/projects/:project_id/tasks"
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
