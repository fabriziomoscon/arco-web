arcoApp = angular.module 'arco', [
  'ngRoute'
]

arcoApp.config ['$routeProvider',
  ($routeProvider) ->
    $routeProvider.
      when('/login', {
        templateUrl: 'partials/auth/login.html',
        controller: 'AuthLoginCtrl'
      }).
      when('/my-scores', {
        templateUrl: 'partials/score/list.html',
        controller: 'ScoreListCtrl'
      }).
      otherwise({
        redirectTo: '/'
      })
]


arcoApp.controller 'ScoreListCtrl', ['$scope', 'Score', ($scope, Score) ->

  $scope.scores = []

]

arcoApp.controller 'AuthLoginCtrl', ['$scope', 'Auth', ($scope, Auth) ->

  $scope.login = Auth.login

]

arcoApp.factory 'Score', ['$http', ($http) ->

  return {

  }

]

arcoApp.factory 'Auth', ['$http', ($http) ->

  return {
    login: () ->
      $http.post( '/auth' )
        .success( (data, status, headers, config) ->
          console.log 'LOGIN success', data, status
        )
        .error( (data, status, headers, config) ->
          console.log 'LOGIN error', data, status
        )
  }
]
