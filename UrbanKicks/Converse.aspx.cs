using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace UrbanKicks
{
    public partial class Converse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadConverseProducts();
            }
        }

        private void LoadConverseProducts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Name, Price, Brand, ImageUrl, ImageUrl2 FROM Products WHERE Brand = @Brand ORDER BY NEWID()";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Brand", "CONVERSE");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        ConverseProductList.DataSource = dt;
                        ConverseProductList.DataBind();
                    }
                    else
                    {
                        ConverseProductList.DataSource = null;
                        ConverseProductList.DataBind();
                    }
                }
            }
        }
    }
}