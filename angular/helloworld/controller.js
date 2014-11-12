var myApp = angular.module('myApp', [])
	.controller('HelloCtrl', ['$scope', function ($scope) {
		$scope.name = 'World';
		$scope.firstname = 'roger';
		$scope.movie = {"title":"shinning", "author":"kubrick", dt:"DT_MOVIE"};
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
	.directive('zzdto', function () {
		return {
			scope: {
      			dto: '=dto'
    		},
		    restrict: 'EA',
		    replace: true,
		    //template: '<div>{{dto.dt == "DT_USER"}}</div>'
		    template: '<div ng-switch on="dto.dt">'
		    +'<div ng-switch-when="DT_USER">{{dto.first}} -{{dto.last}}</div>'
		    +'<div ng-switch-when="DT_MOVIE">{{dto.title}} made by >> {{dto.author}}</div>'
		    +'</div>'
		  };
	});
