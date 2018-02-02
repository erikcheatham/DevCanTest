using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DevCanTest.Models
{
    public class OrderSearchRequest
    {
        public string orderDate { get; set; }
        public string dueDate { get; set; }
        public string shipDate { get; set; }
        public string custID { get; set; }
    }
}