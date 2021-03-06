﻿using DevCanTest.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web.Http;

namespace DevCanTest.Controllers
{
    public class SalesOrderSearchController : ApiController
    {
        // GET: api/SalesOrderSearch
        [HttpGet]
        public HttpResponseMessage OrderSearch()
        {
            OrderSearches os = new OrderSearches();
            //DataTable dt = os.GetOrderSearches<OrderSearches>();

            //Below Much Simpler Ugh
            string json = os.GetOrderSearches();
            //return json;

            //Make proper JSON
            var response = Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(json, System.Text.Encoding.UTF8, "application/json");
            return response;

            #region Not self calling
            //string _apiUrl = String.Format("...");
            //string _baseAddress = "...";

            //using (var client = new HttpClient())
            //{
            //    client.BaseAddress = new Uri(_baseAddress);
            //    client.DefaultRequestHeaders.Accept.Clear();
            //    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            //    var responseMessage = await client.GetAsync(_apiUrl);

            //    if (responseMessage.IsSuccessStatusCode)
            //    {
            //        var response = Request.CreateResponse(HttpStatusCode.OK);
            //        response.Content = responseMessage.Content;
            //        return ResponseMessage(response);
            //    }
            //}
            //return NotFound();
            #endregion
        }

        // GET: api/SalesOrderSearch
        [HttpPost]
        [Route("~/api/OrderSearchAutoComplete")]
        public HttpResponseMessage OrderSearchAutoComplete(AutoComplete request)
        {
            //if (request != null)
            //{
                OrderSearches os = new OrderSearches();
                string json = os.GetOrderSearchesAutoComplete(request.request);

                //Make proper JSON
                var response = Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(json, System.Text.Encoding.UTF8, "application/json");
                return response;
            //}
            //else
            //{
            //    var response = Request.CreateResponse(HttpStatusCode.UnsupportedMediaType);
            //    //response.Content = new StringContent("", System.Text.Encoding.UTF8, "application/json");
            //    return response;
            //}
        }

        // GET: api/SalesOrderSearch
        [HttpPost]
        public HttpResponseMessage OrderSearch(OrderSearchRequest request)
        {
            OrderSearches os = new OrderSearches();
            
            string json = os.GetOrderSearches(request);

            var response = Request.CreateResponse(HttpStatusCode.OK);
            response.Content = new StringContent(json, System.Text.Encoding.UTF8, "application/json");
            return response;
        }
    }
}
