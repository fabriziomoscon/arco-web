angular.module('arco').controller 'AuthCtrl', ['$rootScope', '$location', 'Auth', ($rootScope, $location, Auth) ->

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
