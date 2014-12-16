@mainApp = angular.module 'todo',
[
  'ngRoute'
  'ngResource'
  'templates'
]

@mainApp.config ["$httpProvider", ($httpProvider) ->
  csrfToken = $('meta[name=csrf-token]').attr('content')
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = csrfToken
  return
]