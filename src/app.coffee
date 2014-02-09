app = angular.module 'arco', [
  'ngRoute'
]

app.config ['$routeProvider',
  ($routeProvider) ->
    $routeProvider
      .when('/', {
        templateUrl: 'index.html',
        controller: 'HomeCtrl'
        controllerAs: 'home'
      })
      .when('/login', {
        templateUrl: 'partials/auth/login.html',
        controller: 'AuthLoginCtrl'
        controllerAs: 'auth'
      })
      .when('/my-scores', {
        templateUrl: 'partials/score/list.html',
        controller: 'ScoreListCtrl'
        controllerAs: 'score'
      })
      .otherwise({
        redirectTo: '/'
      })
]

app.controller 'AppCtrl', ['$rootScope', ($rootScope) ->

  $rootScope.$on 'changeRouteError', (event, current, previous, rejection) ->
    console.log 'ERROR changing route'

]

app.controller 'HomeCtrl', ['$scope', ($scope) ->

]

# app.controller 'ScoreListCtrl', ['$scope', 'Score', ($scope, Score) ->

#   $scope.scores = []

# ]

# new feature AnyController as any doesn't need to inject $scope
app.controller 'AuthLoginCtrl', ['Auth', (Auth) ->

  return {

    login: (email, password) ->
      Auth.login(
        email
        password
        (data, status, headers, config) ->
          console.log headers()
          console.log config
          console.log 'LOGIN success', data
          # redirect to /
        (data, status, headers, config) =>
          console.log status
          console.log 'LOGIN error', data
          @errors = data.error
      )

    errors: undefined
  }

]

app.factory 'Routes', [ () ->

  BASE_URL = 'http://localhost:4000/'

  return {
    authLogin: BASE_URL + 'auth/login'
  }
]

app.factory 'Score', ['$http', ($http) ->

  return {

  }

]

app.factory 'Auth', ['$http', 'Routes', ($http, Routes) ->

  return {

    login: (email, password, callback, errorBack) ->

      $http.post( Routes.authLogin, {email, password} )
        .success( callback )
        .error( errorBack )
  }
]
