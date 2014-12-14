@mainApp.factory 'currentUser',
['$resource', ($resource) ->
  @currentUser || @currentUser = $resource('/api/sessions/current_user').get()
]