var myApp = angular.module('myApp', [])
	.controller('HelloCtrl', ['$scope', function ($scope) {
		$scope.name = 'World';
		$scope.firstname = 'roger';
		$scope.users = [
			{"first":"jean", "last":"dupond", dt:"DT_USER"}, 
			{"first":"paul", "last":"rapon", dt:"DT_USER"}
		];
		$scope.dtdefinition={"DT_USER":[{"first":"DO_S"}, {"last":"DO_S"}]};
		$scope.domain={ "DO_S" :{"datatype":"string"}};
	}]);

myApp
	.directive('xinput', function () {
		return {
		    restrict: 'E',
		    replace: true,
		    template: '<input type="text" ng-model="name"/>'
		  };
	})
	.directive('zzfield', function () {
		return {
			scope: {
      			dto: '=dto'
    		},
		    restrict: 'EA',
		    replace: true,
		    template: '<div>{{dto.first}} -- {{dto.last}}</div>'
		  };
	});
