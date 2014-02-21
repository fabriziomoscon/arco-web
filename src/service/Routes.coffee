angular.module('arco').factory 'Routes', [ () ->

  BASE_URL = 'http://localhost:14000/'

  return {
    authLogin: BASE_URL + 'auth/login'
    authLogout: BASE_URL + 'auth/logout'
  }

]
