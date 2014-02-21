angular.module('arco').factory 'Auth', ['$http', '$cookieStore', 'Routes', ($http, $cookieStore, Routes) ->

  return {

    authorize: (accessLevel) ->
      return $cookieStore.get('user')? or accessLevel is 'public'


    isLoggedIn: () -> return $cookieStore.get('user')?


    login: (email, password, callback, errorback) ->

      return $http.post( Routes.authLogin, {email, password} )
        .success( callback )
        .error( errorback )


    logout: (callback, errorback) ->

      return $http.post( Routes.authLogout )
        .success( callback )
        .error( errorback )

  }
]
