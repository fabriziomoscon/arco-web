app = angular.module('arco', [
  'ngRoute', 'ngCookies'
])

app.config ['$routeProvider', '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider
      # .when('/', {
      #   templateUrl:          'index.html',
      #   controller:           'HomeCtrl'
      #   controllerAs:         'home'
      # })
      .when('/login', {
        templateUrl:          'partials/auth/login.html',
        controller:           'AuthCtrl'
        controllerAs:         'auth'
        access:               'public'
      })
      .when('/register', {
          templateUrl:        'partials/auth/register.html',
          controller:         'AuthCtrl',
          controllerAs:       'auth'
          access:             'public'
      })
      .when('/my-scores', {
        templateUrl:          'partials/score/list.html',
        controller:           'ScoreListCtrl'
        controllerAs:         'score'
        access:               'private'
      })
      # .otherwise({
      #   redirectTo: '/notFound'
      # })

    # $locationProvider.html5Mode(true).hashPrefix('!')
]

app.run ['$rootScope', '$location', 'Auth', ($rootScope, $location, Auth) ->

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    unless Auth.authorize(next.access)
      if Auth.isLoggedIn($rootScope.user)
        $location.path('/my-scores')
      else
        $location.path('/login')

]

app.controller 'AppCtrl', ['$rootScope', ($rootScope) ->

  $rootScope.$on 'changeRouteError', (event, current, previous, rejection) ->
    console.log 'ERROR changing route'

]


app.factory 'Score', ['$http', ($http) ->

  return {

  }

]
