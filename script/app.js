;(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var app;

app = angular.module('arco', ['ngRoute']);

app.config([
  '$routeProvider', function($routeProvider) {
    return $routeProvider.when('/', {
      templateUrl: 'index.html',
      controller: 'HomeCtrl'
    }).when('/login', {
      templateUrl: 'partials/auth/login.html',
      controller: 'AuthLoginCtrl'
    }).when('/my-scores', {
      templateUrl: 'partials/score/list.html',
      controller: 'ScoreListCtrl'
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

app.controller('ScoreListCtrl', [
  '$scope', 'Score', function($scope, Score) {
    return $scope.scores = [];
  }
]);

app.controller('AuthLoginCtrl', [
  'Auth', function(Auth) {
    return {
      login: Auth.login
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
      login: function(email, password) {
        return $http.post(Routes.authLogin, {
          email: email,
          password: password
        }).success(function(data, status, headers, config) {
          console.log(headers());
          console.log(config);
          return console.log('LOGIN success', data);
        }).error(function(data, status, headers, config) {
          console.log(status);
          return console.log('LOGIN error', data);
        });
      }
    };
  }
]);


},{}]},{},[1])
;