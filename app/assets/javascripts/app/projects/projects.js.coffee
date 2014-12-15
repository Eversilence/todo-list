@mainApp.factory 'Projects',
['$resource', ($resource) ->
  @projects = $resource('/api/projects')
]