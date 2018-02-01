using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Web;
using DevCanTest.Helpers;
using Newtonsoft.Json;

namespace DevCanTest.Models
{
    public class OrderSearches
    {
        public string CustName { get; set; }
        public string AccountNumber { get; set; }
        public string ShipAddress { get; set; }
        public string ShipMethod { get; set; }
        public decimal SubTotal { get; set; }
        public decimal Tax { get; set; }
        public decimal Freight { get; set; }
        public decimal Total { get; set; }

        public IEnumerator GetEnumerator()
        {
            return (IEnumerator)this;
        }

        public string GetOrderSearches()
        {
            //OrderSearches os = new OrderSearches();
            using (SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["AdventureConnectionString"].ConnectionString))
            {
                myConnection.Open();
                SqlCommand command = new SqlCommand("dbo.getOrderSearchbyDatesOrCustName", myConnection);
                command.CommandType = CommandType.StoredProcedure;
                //if (null != String.Empty)
                //    command.Parameters.AddWithValue("@OrderDate", SqlDbType.Date).Value = null;
                //if (null != String.Empty)
                //    command.Parameters.AddWithValue("@DueDate", SqlDbType.Date).Value = null;
                //if (null != String.Empty)
                //    command.Parameters.AddWithValue("@ShipDate", SqlDbType.Date).Value = null;
                //if (null != String.Empty)
                    command.Parameters.AddWithValue("@CustID", SqlDbType.Int).Value = 29825;

                //List<OrderSearches> list = new List<OrderSearches>();
                DataTable dataTable = new DataTable();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    dataTable.Load(reader);
                    #region GiantWaste
                    //while (reader.Read())
                    //{
                    //Type type = typeof(T);
                    //var properties = type.GetProperties();

                    //foreach (PropertyInfo info in properties)
                    //{
                    //    dataTable.Columns.Add(new DataColumn(info.Name, Nullable.GetUnderlyingType(info.PropertyType) ?? info.PropertyType));
                    //}

                    //list = DataReader.DataReaderMapToList<OrderSearches>(reader);


                    //obj = Activator.CreateInstance<T>();
                    //foreach (PropertyInfo prop in list.GetType().GetProperties())
                    //{
                    //if (!object.Equals(dr[prop.Name], DBNull.Value))
                    //{
                    //    prop.SetValue(obj, dr[prop.Name], null);
                    //}
                    //}
                    //list.Add(obj);

                    //foreach (T entity in list)
                    //{
                    //    object[] values = new object[properties.Length];
                    //    for (int i = 0; i < properties.Length; i++)
                    //    {
                    //        values[i] = reader[i];
                    //    }

                    //    dataTable.Rows.Add(values);
                    //}
                    //}
                    #endregion
                }
                myConnection.Close();
                string JSONString = string.Empty;
                JSONString = JsonConvert.SerializeObject(dataTable);
                return JSONString;

                //return dataTable;
            }
        }
    }
}