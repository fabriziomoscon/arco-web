angular.module('arco').directive 'loggeduser', ['$rootScope', ($rootScope) ->

  return {
    restrict: 'E',
    templateUrl: 'partials/directives/loggeduser.html'
    link: (scope, element, attrs) ->
      $rootScope.$watch 'user', (user) -> scope.user = user
  }

]
