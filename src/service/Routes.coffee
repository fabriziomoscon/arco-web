angular.module('arco').factory 'Routes', [ () ->

  BASE_URL = 'http://localhost:4000/'

  return {
    authLogin: BASE_URL + 'auth/login'
  }
]
