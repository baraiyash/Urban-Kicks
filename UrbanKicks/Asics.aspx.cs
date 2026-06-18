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
    public partial class Asics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAsicsProducts();
            }
        }

        private void LoadAsicsProducts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Name, Price, Brand, ImageUrl, ImageUrl2 FROM Products WHERE Brand = @Brand ORDER BY NEWID()";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Brand", "ASICS");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        AsicsProductList.DataSource = dt;
                        AsicsProductList.DataBind();
                    }
                    else
                    {
                        AsicsProductList.DataSource = null;
                        AsicsProductList.DataBind();
                    }
                }
            }
        }
    }
}