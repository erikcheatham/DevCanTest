//DevCanTest.service('orderSearchService', function ($http, $q) {
//var orderSearchService = function ($http, $q) {
//    delete $http.defaults.headers.common['X-Requested-With'];
//    this.getData = function () {
//        deferred = $q.defer();
//        $http({
//            method: "GET",
//            url: "http://localhost:64648/api/SalesOrderSearch"
//            //headers: {'Authorization': 'Token token=xxxxYYYYZzzz'}
//        }).success(function (data) {
//            // With the data succesfully returned, we can resolve promise and we can access it in controller
//            deferred.resolve();
//        }).error(function () {
//            alert("error");
//            //let the function caller know the error
//            deferred.reject(error);
//        });
//        return deferred.promise;
//    }
//}

var orderSearchService = function ($http) {
    delete $http.defaults.headers.common['X-Requested-With'];
    this.getData = function () {
        // $http() returns a $promise that we can add handlers with .then()
        return $http({
            method: "GET",
            url: "http://localhost:64648/api/SalesOrderSearch"
            //headers: {'Authorization': 'Token token=xxxxYYYYZzzz'}        
        });
    }
}

var orderSearchAutocomplete = function ($http, text) {
    delete $http.defaults.headers.common['X-Requested-With'];
    this.getData = function () {
        // $http() returns a $promise that we can add handlers with .then()
        return $http({
            method: "POST",
            url: "http://localhost:64648/api/OrderSearchAutoComplete",
            data: text
            //headers: {'Authorization': 'Token token=xxxxYYYYZzzz'}        
        });
    }
}