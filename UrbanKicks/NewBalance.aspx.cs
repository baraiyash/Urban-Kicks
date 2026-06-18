using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace UrbanKicks
{
    public partial class NewBalance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNewBalanceProducts();
            }
        }

        private void LoadNewBalanceProducts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Name, Price, Brand, ImageUrl, ImageUrl2 FROM Products WHERE Brand = @Brand ORDER BY NEWID()";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Brand", "NEW BALANCE");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        NewBalanceProductList.DataSource = dt;
                        NewBalanceProductList.DataBind();
                    }
                    else
                    {
                        NewBalanceProductList.DataSource = null;
                        NewBalanceProductList.DataBind();
                    }
                }
            }
        }
    }
}
