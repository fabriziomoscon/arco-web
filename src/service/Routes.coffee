app.factory 'Routes', [ () ->

  BASE_URL = 'http://127.0.0.1:4000/'

  return {
    authLogin:  BASE_URL + 'auth/login'
    authLogout: BASE_URL + 'auth/logout'
  }

]
