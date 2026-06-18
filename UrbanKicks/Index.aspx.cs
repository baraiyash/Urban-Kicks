using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace UrbanKicks
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Name, Price, Brand, ImageUrl, ImageUrl2 FROM Products ORDER BY NEWID()";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    ProductList.DataSource = dt;
                    ProductList.DataBind();
                }
                else
                {
                    ProductList.DataSource = null;
                    ProductList.DataBind();
                }
            }
        }
    }
}
