using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DevCanTest.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult OrderSearch()
        {
            return View();
        }

        public ActionResult OrderDetail()
        {
            return View();
        }
    }
}