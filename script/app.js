;(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var app;

app = angular.module('arco', ['ngRoute']);

app.config([
  '$routeProvider', function($routeProvider) {
    return $routeProvider.when('/', {
      templateUrl: 'index.html',
      controller: 'HomeCtrl',
      controllerAs: 'home'
    }).when('/login', {
      templateUrl: 'partials/auth/login.html',
      controller: 'AuthLoginCtrl',
      controllerAs: 'auth'
    }).when('/my-scores', {
      templateUrl: 'partials/score/list.html',
      controller: 'ScoreListCtrl',
      controllerAs: 'score'
    }).otherwise({
      redirectTo: '/'
    });
  }
]);

app.controller('AppCtrl', [
  '$rootScope', function($rootScope) {
    return $rootScope.$on('changeRouteError', function(event, current, previous, rejection) {
      return console.log('ERROR changing route');
    });
  }
]);

app.controller('HomeCtrl', ['$scope', function($scope) {}]);

app.controller('AuthLoginCtrl', [
  'Auth', function(Auth) {
    return {
      login: function(email, password) {
        var _this = this;
        return Auth.login(email, password, function(data, status, headers, config) {
          console.log(headers());
          console.log(config);
          return console.log('LOGIN success', data);
        }, function(data, status, headers, config) {
          console.log(status);
          console.log('LOGIN error', data);
          return _this.errors = data.error;
        });
      },
      errors: void 0
    };
  }
]);

app.factory('Routes', [
  function() {
    var BASE_URL;
    BASE_URL = 'http://localhost:4000/';
    return {
      authLogin: BASE_URL + 'auth/login'
    };
  }
]);

app.factory('Score', [
  '$http', function($http) {
    return {};
  }
]);

app.factory('Auth', [
  '$http', 'Routes', function($http, Routes) {
    return {
      login: function(email, password, callback, errorBack) {
        return $http.post(Routes.authLogin, {
          email: email,
          password: password
        }).success(callback).error(errorBack);
      }
    };
  }
]);


},{}]},{},[1])
;