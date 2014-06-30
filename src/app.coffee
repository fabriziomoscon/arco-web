localurl = {
  home:          '/'
  login:         '/login'
  register:      '/register'
  my_scores:     '/my-scores'
}


app = angular.module('arco', [
  'ngRoute'
])

app.config ['$routeProvider', '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider
      .when(localurl.home, {
        templateUrl:          'partials/home/main.html'
        access:               'public'
      })
      .when(localurl.login, {
        templateUrl:          'partials/auth/login.html'
        access:               'public'
      })
      .when(localurl.register, {
        templateUrl:        'partials/auth/register.html'
        access:             'public'
      })
      .when(localurl.my_scores, {
        templateUrl:          'partials/score/list.html'
        access:               'private'
      })

    $locationProvider.html5Mode(true).hashPrefix('!')

    $httpProvider.interceptors.push 'ResponseInterceptor'

    $httpProvider.defaults.withCredentials = true
]

app.factory 'ResponseInterceptor', ['$rootScope', '$location', '$q', 'LocalStorage', ($rootScope, $location, $q, LocalStorage) ->
  return {

    request: (config) -> return config || $q.when config
    requestError: (rejection) -> return $q.reject rejection
    response: (response) -> return response || $q.when response
    responseError: (response) ->

      if response.status is 0
        $rootScope.errors = 'SERVER CONNECTION REFUSED'
        return $q.reject response

      else if response.status is 401
        delete $rootScope.user
        delete LocalStorage['user']
        $location.path localurl.login
        return $q.reject response

      else
        return $q.reject response

  }

]


app.run ['$rootScope', 'LocalStorage', '$location', 'Auth', ($rootScope, LocalStorage, $location, Auth) ->

  $rootScope.localurl = localurl

  if LocalStorage['user']?
    try $rootScope.user = JSON.parse LocalStorage['user']
    catch e
      console.log 'Impossible to parse user in local storage'
      console.log e
      delete $rootScope.user
      delete LocalStorage['user']
      $location.path localurl.login
      return

  
  $rootScope.$on '$routeChangeStart', (event, next, current) ->

    unless next?
      return

    if next.$$route?.resolve?
      $rootScope.loadingView = true

    unless Auth.authorize(next.access)
      if Auth.isLoggedIn()
        $location.path localurl.my_scores
      else
        $location.path localurl.login

  $rootScope.$on '$routeChangeSuccess', (event, next, current) ->
    $rootScope.loadingView = false

]


app.controller 'AppCtrl', ['$rootScope', ($rootScope) ->

  $rootScope.$on 'changeRouteError', (event, current, previous, rejection) ->
    console.log 'ERROR changing route'

]

