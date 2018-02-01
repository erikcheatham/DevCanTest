//angular
//    .module('DevCanTest')

/**
OrderSearch Controller
**/

//.controller('OrderSearch', function ($scope, orderSearchService) {
var OrderSearchAdvanced = function ($scope, orderSearchService) {
    $scope.MyAPIReturn = null;
    $scope.callAPI = function () {
        orderSearchService.getData().then(function (response) {
            $scope.MyAPIReturn = response;
        });
    }
    //orderSearchService.getData().then(function (response) {
    //    $scope.MyAPIReturn = response.data;
    //});
    $scope.callAPIAutoComplete = function (text) {
        if (text.length >= 3)
            orderSearchAutocomplete.getData().then(function (response) {
                $scope.AutoComplete = response;
            });
    }

    $scope.callAPIPost = function (orderDate, dueDate, shipDate, custname) {
        //$scope.
    }

    $scope.datepickerShip = function () { $("#datepickerShip").datepicker(); };
    $scope.datepickerOrder = function () { $("#datepickerOrder").datepicker(); };
    $scope.datepickerDue = function () { $("#datepickerDue").datepicker(); };
}

OrderSearchAdvanced.$inject = ['$scope', 'orderSearchService'];


//var OrderSearch = function ($scope, orderSearchService) {
//    $scope.MyAPIReturn = null;
//    //callAPI()
//    orderSearchService.getData().then(function (dataResponse) {
//        $scope.MyAPIReturn = dataResponse;
//    });
//}
//OrderSearch.$inject = ['$scope'];

