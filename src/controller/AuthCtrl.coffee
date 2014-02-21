angular.module('arco').controller 'AuthCtrl', ['$cookieStore', '$location', 'Auth', '$rootScope', ($cookieStore, $location, Auth, $rootScope) ->

  return {

    login: (email, password) ->
      Auth.login(
        email
        password
        (data, status, headers, config) ->
          $cookieStore.put 'user', {first_name: data.first_name, last_name: data.last_name}
          $rootScope.user = {first_name: data.first_name, last_name: data.last_name}
          $location.path('/my-scores')

        (data, status, headers, config) =>
          @errors = data.error
      )


    register: (first_name, last_name, email, password) ->


    logout: () ->
      delete $rootScope.user
      Auth.logout(
        (data, status, headers, config) ->
          $cookieStore.remove 'user'
          $location.path '/login'
        (data, status, headers, config) ->
          $cookieStore.remove 'user'
          $location.path '/login'
      )


    errors: undefined
  }

]
