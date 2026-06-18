using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace UrbanKicks.admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                lblFlights.Text = GetCount(conn, "SELECT COUNT(*) FROM Products");
                lblUsers.Text = GetCount(conn, "SELECT COUNT(*) FROM Users");
                lblBookings.Text = GetCount(conn, "SELECT COUNT(*) FROM PurchaseData");
                lblClasses.Text = GetCount(conn, "SELECT COUNT(*) FROM Brands");
            }
        }

        private string GetCount(SqlConnection conn, string query)
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                return cmd.ExecuteScalar().ToString();
            }
        }
    }
}