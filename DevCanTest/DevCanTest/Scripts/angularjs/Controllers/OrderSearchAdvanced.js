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
            orderSearchService.postData(text).then(function (response) {
                $scope.AutoComplete = response;
            });
    }

    $scope.callAPIPost = function (orderDate, dueDate, shipDate, custname) {
        //$scope.
    }


    $scope.myData = [
        {
            firstName: "Cox",
            lastName: "Carney",
            company: "Enormo",
            employed: true
        },
        {
            firstName: "Lorraine",
            lastName: "Wise",
            company: "Comveyer",
            employed: false
        },
        {
            firstName: "Nancy",
            lastName: "Waters",
            company: "Fuelton",
            employed: false
        }
    ];


    $(function () { $("#datepickerShip").datepicker(); });
    $(function () { $("#datepickerOrder").datepicker(); });
    $(function () { $("#datepickerDue").datepicker(); });


}
OrderSearchAdvanced.$inject = ['$scope', 'orderSearchService'];

