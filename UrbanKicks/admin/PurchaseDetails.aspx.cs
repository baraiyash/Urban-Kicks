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
    public partial class PurchaseDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBookings();
            }
        }

        private void LoadBookings()
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                //string sql = @"SELECT Users.username, Products.Id, Brands.Brand,
                //                      PurchaseData.date_of_purchase, PurchaseData.final_total, PurchaseData.Id 
                //               FROM PurchaseData 
                //               INNER JOIN Users ON PurchaseData.Id = Users.Id 
                //               INNER JOIN Products ON PurchaseData.product_id = Products.Id
                //               ORDER BY PurchaseData.date_of_purchase DESC";

                string sql = @"SELECT Users.username, 
                                       Products.Id AS ProductId, 
                                       Products.Brand, 
                                       PurchaseData.date_of_purchase,  
                                       PurchaseData.final_total, 
                                       PurchaseData.payment_method,
                                       PurchaseData.Id AS PurchaseId
                                FROM PurchaseData
                                INNER JOIN Users ON PurchaseData.user_id = Users.Id
                                INNER JOIN Products ON PurchaseData.product_id = Products.Id
                                ORDER BY PurchaseData.Id DESC;";


                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    BookingGrid.DataSource = dt;
                    BookingGrid.DataBind();
                }
            }
        }

        //protected void BookingGrid_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "Reject")
        //    {
        //        int bookingId;
        //        if (int.TryParse(e.CommandArgument.ToString(), out bookingId))
        //        {
        //            RejectBooking(bookingId);
        //        }
        //    }
        //}

        //private void RejectBooking(int bookingId)
        //{
        //    string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["FlightMateDB"].ConnectionString;
        //    using (SqlConnection conn = new SqlConnection(connStr))
        //    {
        //        string sql = "UPDATE Bookings SET status='rejected' WHERE booking_id=@booking_id";

        //        using (SqlCommand cmd = new SqlCommand(sql, conn))
        //        {
        //            cmd.Parameters.AddWithValue("@booking_id", bookingId);
        //            conn.Open();
        //            cmd.ExecuteNonQuery();
        //        }
        //    }

        //    // Refresh the booking list
        //    LoadBookings();
        //}
    }
}