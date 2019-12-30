angular.module('sortApp', [])

.controller('mainController', function ($scope) {
    $scope.sortType = 'name'; // set the default sort type
    $scope.sortReverse = false;  // set the default sort order
    $scope.searchFish = '';     // set the default search/filter term

    // create the list of sushi rolls 
    $scope.sushi = [
      { name: 'Cali Roll', fish: 'Crab', tastiness: 2 },
      { name: 'Philly', fish: 'Tuna', tastiness: 4 },
      { name: 'Tiger', fish: 'Eel', tastiness: 7 },
      { name: 'Rainbow', fish: 'Variety', tastiness: 6 }
    ];
    // backup for $scope.sushi
    $scope.sushiBac = angular.copy($scope.sushi);

    $scope.save = function () {
        $scope.sushiBac = angular.copy($scope.sushi);
        $("tbody td").css("color", "black");
    }

    $scope.reset = function () {
        $scope.sushi = angular.copy($scope.sushiBac);
        $("tbody td").css("color", "black");
    }

    $scope.$watch('sushi', function (newVal, oldVal) {
        //$scope.person.isDirty = $scope.person.isDirty || newValue;
        $(event.target).parent().css("color","red")
    }, true);
    
});