@mainApp = angular.module 'todo',
[
  'ngRoute'
  'ngResource'
  'templates'
  'ngAnimate'
  'mgcrea.ngStrap'
  'angularFileUpload'
  'ui.tree'
]

@mainApp.config ["$httpProvider", ($httpProvider) ->
  csrfToken = $('meta[name=csrf-token]').attr('content')
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = csrfToken
  return
]
