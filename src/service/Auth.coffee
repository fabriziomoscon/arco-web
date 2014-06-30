app.factory 'Auth', ['$http', 'LocalStorage', 'Routes', ($http, LocalStorage, Routes) ->

  _destroyLocalUserData = () -> return delete LocalStorage['user']

  return {

    authorize: (accessLevel) ->
      return LocalStorage['user']? or accessLevel is 'public'


    isLoggedIn: () ->
      return LocalStorage['user']?


    login: (email, password, callback) ->

      return $http.post( Routes.authLogin, {email, password} )
        .success(
          (data, status, headers, config) ->
            unless data.body?.user?
              return callback 'Impossible to fetch the user'

            LocalStorage['user'] = JSON.stringify data.body.user
            return callback null, data.body.user
        )
        .error(
          (data, status, headers, config) ->
            unless data?.body?.error?
              return callback 'No server response'

            return callback data.body.error
        )


    logout: (callback) ->

      return $http.post( Routes.authLogout )
        .success(
          (data, status, headers, config) ->
            _destroyLocalUserData()
            return callback null, true
        )
        .error(
          (data, status, headers, config) ->
            _destroyLocalUserData()

            unless data?.body?.error?
              return callback 'No server response'

            return callback data.body.error
        )

  }

]
