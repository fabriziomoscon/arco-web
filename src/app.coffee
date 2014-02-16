app = angular.module 'arco', [
  'ngRoute', 'ngCookies'
]

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
    console.log '$routeChangeStart', next
    unless Auth.authorize(next.access)
      if Auth.isLoggedIn($rootScope.user)
        console.log 'LOGGED IN'
        $location.path('/my-scores')
      else
        console.log 'NOT LOGGED IN'
        $location.path('/login')

]

app.controller 'AppCtrl', ['$rootScope', ($rootScope) ->

  $rootScope.$on 'changeRouteError', (event, current, previous, rejection) ->
    console.log 'ERROR changing route'

]

app.controller 'HomeCtrl', [ () ->

  return {}

]

app.controller 'ScoreListCtrl', ['Score', (Score) ->

  return {
    scores: []
  }

]

# new feature AnyController as any doesn't need to inject $scope
app.controller 'AuthCtrl', ['$rootScope', '$location', 'Auth', ($rootScope, $location, Auth) ->

  return {

    login: (email, password) ->
      Auth.login(
        email
        password
        (data, status, headers, config) ->
          console.log headers()
          console.log config
          console.log 'LOGIN success', data
          $rootScope.user = data
          $location.path('/my-scores')

        (data, status, headers, config) =>
          console.log status
          console.log 'LOGIN error', data
          @errors = data.error
      )

    register: (first_name, last_name, email, password) ->

    logout: () ->

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

app.factory 'Auth', ['$http', '$cookieStore', '$rootScope', 'Routes', ($http, $cookieStore, $rootScope, Routes) ->

  anonUser = { first_name: '', last_name: '' }
  currentUser = $cookieStore.get('user') or anonUser

  return {

    authorize: (accessLevel, role) ->
      # unless role?
      #   role = $rootScope.user.role;
      # return accessLevel & role
      return $rootScope.user? or accessLevel is 'public'
    
    isLoggedIn: (user) ->
      console.log "$cookieStore.get('user')", $cookieStore.get('user')
      console.log '$rootScope.user', $rootScope.user
      return user?.id?

    login: (email, password, callback, errorBack) ->

      $http.post( Routes.authLogin, {email, password} )
        .success( callback )
        .error( errorBack )

    logout: () ->
      $rootScope.user = anonUser
  }
]

app.directive 'loggeduser', ['$rootScope', ($rootScope) ->

  return {
    restrict: 'E',
    templateUrl: 'partials/directives/loggeduser.html'
    link: (scope, element, attrs) ->
      $rootScope.$watch 'user', (user) -> scope.user = user
  }

]
