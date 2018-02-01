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

        #region OverComplicated
        public DataTable GetOrderSearches<T>()
        {
            //OrderSearches os = new OrderSearches();
            using (SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["AdventureConnectionString"].ConnectionString))
            {
                myConnection.Open();
                SqlCommand command = new SqlCommand("dbo.getOrderSearchbyDatesOrCustName", myConnection);
                command.CommandType = CommandType.StoredProcedure;

                List<T> list = new List<T>();
                DataTable dataTable = new DataTable();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    //Finally Found That reader.Read() method is the culprit 
                    //For not returning the select rows information from the sproc
                    while (reader.Read())
                    {
                        #region First Attempt
                        Type type = typeof(T);
                        var properties = type.GetProperties();

                        foreach (PropertyInfo info in properties)
                        {
                            dataTable.Columns.Add(new DataColumn(info.Name, Nullable.GetUnderlyingType(info.PropertyType) ?? info.PropertyType));
                        }

                        foreach (T entity in list)
                        {
                            object[] values = new object[properties.Length];
                            for (int i = 0; i < properties.Length; i++)
                            {
                                values[i] = reader[i];
                            }

                            dataTable.Rows.Add(values);
                        }
                        #endregion
                        
                        #region Second Attempts

                        #region Collections Return With Rows But Empty Of Properties And Values - Why!?!?!
                        list = DataReader.DataReaderMapToList<T>(reader);

                        DataReader.DataReaderMapToList<T>(reader, ref dataTable);
                        #endregion

                        #endregion
                    }
                    return dataTable;
                }
            }
        }
        #endregion

        public string GetOrderSearches()
        {
            using (SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["AdventureConnectionString"].ConnectionString))
            {
                myConnection.Open();
                SqlCommand command = new SqlCommand("dbo.getOrderSearchbyDatesOrCustName", myConnection);
                command.CommandType = CommandType.StoredProcedure;
                //Test Command
                //command.Parameters.AddWithValue("@CustID", SqlDbType.Int).Value = 29825;

                //if (null != String.Empty)
                //    command.Parameters.AddWithValue("@OrderDate", SqlDbType.Date).Value = null;
                //if (null != String.Empty)
                //    command.Parameters.AddWithValue("@DueDate", SqlDbType.Date).Value = null;
                //if (null != String.Empty)
                //    command.Parameters.AddWithValue("@ShipDate", SqlDbType.Date).Value = null;
                //if (null != String.Empty)
                command.Parameters.AddWithValue("@CustID", SqlDbType.Int).Value = 29825;

                DataTable dataTable = new DataTable();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    //All That Work Above & This Is What It Was!!!!
                    dataTable.Load(reader);
                }
                myConnection.Close();
                string JSONString = string.Empty;
                JSONString = JsonConvert.SerializeObject(dataTable);
                return JSONString;
            }
        }

        public string GetOrderSearchesAutoComplete(string text)
        {
            if (!string.IsNullOrEmpty(text.Trim()))
                using (SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["AdventureConnectionString"].ConnectionString))
                {
                    myConnection.Open();
                    SqlCommand command = new SqlCommand("dbo.getOrderSearchAutoComplete", myConnection);
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@text", SqlDbType.NVarChar).Value = text;
                    DataTable dataTable = new DataTable();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        dataTable.Load(reader);
                    }
                    myConnection.Close();
                    string JSONString = string.Empty;
                    JSONString = JsonConvert.SerializeObject(dataTable);
                    return JSONString;
                }
            else
                return "";
        }
    }
}