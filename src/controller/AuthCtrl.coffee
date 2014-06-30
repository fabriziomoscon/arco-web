app.controller 'AuthCtrl', ['$location', 'Auth', '$rootScope', ($location, Auth, $rootScope) ->

  return {

    login: (email, password) ->
      Auth.login(
        email
        password
        (err, user) ->
          if err?
            return @errors = err

          $rootScope.user = user
          $location.path $rootScope.localurl.my_scores
          return
      )


    register: (first_name, last_name, email, password) ->


    logout: () ->
      delete $rootScope.user
      Auth.logout(
        (err, success) ->
          if err?
            return @errors = err

          $location.path $rootScope.localurl.home
          return
      )


    errors: undefined
  }

]
