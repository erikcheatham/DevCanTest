//angular
//    .module('DevCanTest')

///**
//OrderSearch Controller
//**/

//.controller('OrderSearch', function ($scope, orderSearchService) {
var OrderSearchAdvanced = function ($scope, $timeout, $q, $log, orderSearchService) {
    $scope.MyAPIReturn = null;
    $scope.results = [];
    $scope.custID = null;
    $scope.shipDate = null;
    $scope.orderDate = null;
    $scope.dueDate = null;
    //var text = null;

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
            orderSearchService.postAutoComplete(text).then(function (response) {
                $scope.AutoComplete = response;
            });
    }

    //$scope.callAPIPost = function () {
    //    orderSearchService.getData().then(function (response) {
    //        return response.data;
    //    });
    //}

    $scope.gridOptions = {};

    $scope.gridOptions.onRegisterApi = function (gridApi) {
        $scope.gridApi = gridApi;
    };

    $scope.callAPIPost = function () {

        $scope.gridOptions.columnDefs = new Array();

        $scope.gridOptions.columnDefs.push({
            field: 'CustomerName'
        });
        $scope.gridOptions.columnDefs.push({
            field: 'AccountNumber'
        });
        $scope.gridOptions.columnDefs.push({
            field: 'ShipToAddress'
        });
        $scope.gridOptions.columnDefs.push({
            field: 'Name'
        });
        $scope.gridOptions.columnDefs.push({
            field: 'SubTotal'
        });
        $scope.gridOptions.columnDefs.push({
            field: 'TaxAmt'
        });
        $scope.gridOptions.columnDefs.push({
            field: 'Freight'
        });
        $scope.gridOptions.columnDefs.push({
            field: 'TotalDue'
        });

        //$scope.gridOptions.data = dataTest;
        //$scope.gridApi.grid.refresh();

        orderSearchService.postData($scope.orderDate, $scope.dueDate, $scope.shipDate, $scope.custID).then(function (response) {
            $timeout(function () {
                $scope.gridOptions.data = response.data;
                $scope.gridApi.grid.refresh();
            }, 500);
        });

        //alert("Rebinding");

        //$scope.gridOptions.data = orderSearchService.getData().then(function (response) {
        //    return response.data;
        //});
        //$scope.gridOptions = {
        //    enableSorting: true,
        //    data: function () {
        //        orderSearchService.getData().then(function (response) {
        //            return this.response.data;
        //        });
        //    }
        //};        
    }

    //$scope.gridOptions = {
    //    enableSorting: true,
    //    data: [
    //        {
    //            firstName: "Cox",
    //            lastName: "Carney",
    //            company: "Enormo",
    //            employed: true
    //        },
    //        {
    //            firstName: "Lorraine",
    //            lastName: "Wise",
    //            company: "Comveyer",
    //            employed: false
    //        },
    //        {
    //            firstName: "Nancy",
    //            lastName: "Waters",
    //            company: "Fuelton",
    //            employed: false
    //        }
    //    ]
    //};

    var dataTest = [
        { "CustomerName": "James Hendergart", "AccountNumber": "10-4020-000676", "ShipToAddress": "42525 Austell Road Austell GA  30106", "Name": "CARGO TRANSPORT 5", "SubTotal": 20565.6206, "TaxAmt": 1971.5149, "Freight": 616.0984, "TotalDue": 23153.2339 },
        { "CustomerName": "James Hendergart", "AccountNumber": "10-4020-000676", "ShipToAddress": "42525 Austell Road Austell GA  30106", "Name": "CARGO TRANSPORT 5", "SubTotal": 20565.6206, "TaxAmt": 1971.5149, "Freight": 616.0984, "TotalDue": 23153.2339 }
    ];

    $(function () {
        $("#datepickerShip").datepicker({
            onSelect: function () {
                $scope.shipDate = $(this).datepicker('getDate');
            }
        });
    });

    $(function () {
        $("#datepickerOrder").datepicker({
            onSelect: function () {
                $scope.orderDate = $(this).datepicker('getDate');
            }
        });
    });

    $(function () {
        $("#datepickerDue").datepicker({
            onSelect: function () {
                $scope.dueDate = $(this).datepicker('getDate');
            }
        });
    });

    //MAterial Design AutoComplete Code
    var self = this;
    self.simulateQuery = false;
    self.isDisabled = false;

    // list of `state` value/display objects
    //self.states = loadAll();
    self.querySearch = querySearch;
    self.selectedItemChange = selectedItemChange;
    self.searchTextChange = searchTextChange;
    self.newState = newState;

    function newState(state) {
        alert("Sorry! You'll need to create a Constitution for " + state + " first!");
    }

    // ******************************
    // Internal methods
    // ******************************

    ///**
    // * Search for states... use $timeout to simulate
    // * remote dataservice call.
    // */
    function querySearch(query) {
        var results = orderSearchService.postAutoComplete(query).then(function (response) {
            return response.data;
        });

        if (self.simulateQuery) {
            results = orderSearchService.postData(query).then(function (response) {
                return response.data;
            });
            //return deferred.resolve(response.data);
        } else {
            return results;
        }
    }

    function searchTextChange(text) {
        $log.info('Text changed to ' + text);
    }

    function selectedItemChange(item) {
        //$log.getInstance('app').info('Hello World');
        //$scope.custID = null;
        if (!isNAN(item.custID)) {
            $scope.custID = item.CustID;
        }
        $log.info('Item changed to ' + JSON.stringify(item));
    }

    ///**
    // * Build `states` list of key/value pairs
    // */
    //function loadAll() {
    //    var allStates = 'Alabama, Alaska, Arizona, Arkansas, California, Colorado, Connecticut, Delaware,\
    //          Florida, Georgia, Hawaii, Idaho, Illinois, Indiana, Iowa, Kansas, Kentucky, Louisiana,\
    //          Maine, Maryland, Massachusetts, Michigan, Minnesota, Mississippi, Missouri, Montana,\
    //          Nebraska, Nevada, New Hampshire, New Jersey, New Mexico, New York, North Carolina,\
    //          North Dakota, Ohio, Oklahoma, Oregon, Pennsylvania, Rhode Island, South Carolina,\
    //          South Dakota, Tennessee, Texas, Utah, Vermont, Virginia, Washington, West Virginia,\
    //          Wisconsin, Wyoming';

    //    return allStates.split(/, +/g).map(function (state) {
    //        return {
    //            value: state.toLowerCase(),
    //            display: state
    //        };
    //    });
    //}

    ///**
    // * Create filter function for a query string
    // */
    function createFilterFor(query) {
        var lowercaseQuery = angular.lowercase(query);

        return function filterFn(state) {
            return (state.value.indexOf(lowercaseQuery) === 0);
        };
    }
}
OrderSearchAdvanced.$inject = ['$scope', '$timeout', '$q', '$log', 'orderSearchService'];