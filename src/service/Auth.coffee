angular.module('arco').factory 'Auth', ['$http', '$cookieStore', '$rootScope', 'Routes', ($http, $cookieStore, $rootScope, Routes) ->

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
