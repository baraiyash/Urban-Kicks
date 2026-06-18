using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace UrbanKicks
{
    public partial class Nike : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNikeProducts();
            }
        }

        private void LoadNikeProducts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Name, Price, Brand, ImageUrl, ImageUrl2 FROM Products WHERE Brand = @Brand ORDER BY NEWID()";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Brand", "NIKE");
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        NikeProductList.DataSource = dt;
                        NikeProductList.DataBind();
                    }
                    else
                    {
                        NikeProductList.DataSource = null;
                        NikeProductList.DataBind();
                    }
                }
            }
        }
    }
}
