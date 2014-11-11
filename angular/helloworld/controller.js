var myApp = angular.module('myApp', [])
	.controller('HelloCtrl', ['$scope', function ($scope) {
		$scope.name = 'World';
		$scope.firstname = 'roger';
	}]);

myApp.directive('xinput', function () {
	return {
	    //restrict: 'A',
	    replace: true,
	    //transclude: true,
	    template: '<input type="text" ng-model="name" />'
/*	    link: function (scope, element, attrs) {
	      // DOM manipulation/events here!
	    }
*/	  };
});
