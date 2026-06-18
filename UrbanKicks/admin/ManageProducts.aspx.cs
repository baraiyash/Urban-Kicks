using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace UrbanKicks.admin
{
    public partial class ManageProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFlights();
            }
        }

        private void LoadFlights()
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Products";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        GridViewFlights.DataSource = dt;
                        GridViewFlights.DataBind();
                    }
                }
            }
        }

        protected void DeleteFlight_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int flightId = Convert.ToInt32(btn.CommandArgument);
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "DELETE FROM PurchaseData WHERE product_id = @ProductID; DELETE FROM Products WHERE Id = @ProductID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ProductID", flightId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            LoadFlights();
        }
    }
}