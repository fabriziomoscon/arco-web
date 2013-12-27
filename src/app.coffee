app = angular.module 'arco', [
  'ngRoute'
]

app.config ['$routeProvider',
  ($routeProvider) ->
    $routeProvider
      .when('/', {
        templateUrl: 'index.html',
        controller: 'HomeCtrl'
      })
      .when('/login', {
        templateUrl: 'partials/auth/login.html',
        controller: 'AuthLoginCtrl'
      })
      .when('/my-scores', {
        templateUrl: 'partials/score/list.html',
        controller: 'ScoreListCtrl'
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

app.controller 'ScoreListCtrl', ['$scope', 'Score', ($scope, Score) ->

  $scope.scores = []

]

# new feature AnyController as any doesn't need to inject $scope
app.controller 'AuthLoginCtrl', ['Auth', (Auth) ->

  return {
    login: Auth.login
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
    login: (email, password) ->
      $http.post( Routes.authLogin, {email, password} )
        .success( (data, status, headers, config) ->
          console.log headers()
          console.log config
          console.log 'LOGIN success', data
        )
        .error( (data, status, headers, config) ->
          console.log status
          console.log 'LOGIN error', data
        )
  }
]
