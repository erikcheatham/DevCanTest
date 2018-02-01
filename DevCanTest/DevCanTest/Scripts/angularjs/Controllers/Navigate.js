/**
Navigate Controller
**/

var Navigate = function ($scope) {
    $scope.goToOrderSearch = function () {
        $window.location.href = "/OrderSearch";
    }
    $scope.goToOrderDetail = function () {
        $window.location.href = "/OrderDetail";
    }
}
Navigate.$inject = ['$scope'];

