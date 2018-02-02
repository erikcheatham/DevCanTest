//angular
//    .module('DevCanTest')

/**
OrderSearch Controller
**/

//.controller('OrderSearch', function ($scope, orderSearchService) {
var OrderSearchAdvanced = function ($scope, $timeout, $q, $log, orderSearchService) { 
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


    //MAterial Design AutoComplete Code
    var self = this;
    self.simulateQuery = false;
    self.isDisabled = false;

    // list of `state` value/display objects
    self.states = loadAll();
    self.querySearch = querySearch;
    self.selectedItemChange = selectedItemChange;
    self.searchTextChange = searchTextChange;
    self.newState = newState;

    $scope.MyAPIReturn = null;
    $scope.results = [];
    $scope.CustID = null;

    function newState(state) {
        alert("Sorry! You'll need to create a Constitution for " + state + " first!");
    }

    // ******************************
    // Internal methods
    // ******************************

    /**
     * Search for states... use $timeout to simulate
     * remote dataservice call.
     */
    function querySearch(query) {
        var results = orderSearchService.postData(query).then(function (response) {
            return response.data;
        });
        if (self.simulateQuery) {
                orderSearchService.postData(query).then(function (response) {
                    return results = response.data;
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
        $log.info('Item changed to ' + JSON.stringify(item));
        $scope.CustID = item.CustID;
    }

    /**
     * Build `states` list of key/value pairs
     */
    function loadAll() {
        var allStates = 'Alabama, Alaska, Arizona, Arkansas, California, Colorado, Connecticut, Delaware,\
              Florida, Georgia, Hawaii, Idaho, Illinois, Indiana, Iowa, Kansas, Kentucky, Louisiana,\
              Maine, Maryland, Massachusetts, Michigan, Minnesota, Mississippi, Missouri, Montana,\
              Nebraska, Nevada, New Hampshire, New Jersey, New Mexico, New York, North Carolina,\
              North Dakota, Ohio, Oklahoma, Oregon, Pennsylvania, Rhode Island, South Carolina,\
              South Dakota, Tennessee, Texas, Utah, Vermont, Virginia, Washington, West Virginia,\
              Wisconsin, Wyoming';

        return allStates.split(/, +/g).map(function (state) {
            return {
                value: state.toLowerCase(),
                display: state
            };
        });
    }

    /**
     * Create filter function for a query string
     */
    function createFilterFor(query) {
        var lowercaseQuery = angular.lowercase(query);

        return function filterFn(state) {
            return (state.value.indexOf(lowercaseQuery) === 0);
        };

    }

}
OrderSearchAdvanced.$inject = ['$scope', '$timeout', '$q', '$log', 'orderSearchService'];

