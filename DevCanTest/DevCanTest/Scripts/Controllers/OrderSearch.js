//angular
//    .module('DevCanTest')

/**
OrderSearch Controller
**/

//.controller('OrderSearch', function ($scope, orderSearchService) {
var OrderSearch = function ($scope, orderSearchService) {
    $scope.MyAPIReturn = null;
    $scope.callAPI = function () {
        orderSearchService.getData().then(function (response) {
            $scope.MyAPIReturn = response;
        });
    }
    //orderSearchService.getData().then(function (response) {
    //    $scope.MyAPIReturn = response.data;
    //});
}
OrderSearch.$inject = ['$scope', 'orderSearchService'];


//var OrderSearch = function ($scope, orderSearchService) {
//    $scope.MyAPIReturn = null;
//    //callAPI()
//    orderSearchService.getData().then(function (dataResponse) {
//        $scope.MyAPIReturn = dataResponse;
//    });
//}
//OrderSearch.$inject = ['$scope'];

