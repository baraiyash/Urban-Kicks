using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanKicks
{
    public partial class Checkout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("SignIn.aspx");
            }

            if (!IsPostBack)  // ✅ Prevents duplicate product entries
            {
                LoadPurchaseDetails();
            }
        }

        private void LoadPurchaseDetails()
        {
            if (Session["PurchasedProductIds"] == null)
            {
                Response.Write("<script>alert('No purchase found! Redirecting to products page.'); window.location='Index.aspx';</script>");
                return;
            }

            List<int> productIds = (List<int>)Session["PurchasedProductIds"];
            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            decimal totalAmount = 0; // To store total price
            string paymentMethod = "";

            // ✅ Reset the literal to avoid duplicate entries
            litProductDetails.Text = "";

            // Get unique product IDs
            List<int> uniqueProductIds = productIds.Distinct().ToList();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                foreach (int productId in uniqueProductIds) // Loop only through unique product IDs
                {
                    string query = @"
            SELECT pr.Name, pr.Price, SUM(p.quantity) AS TotalQuantity, 
                   SUM(p.final_total) AS TotalFinalAmount, p.payment_method
            FROM PurchaseData p
            JOIN Products pr ON p.product_id = pr.Id
            WHERE p.product_id = @productId
            GROUP BY pr.Name, pr.Price, p.payment_method";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@productId", productId);
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            // ✅ No more duplicate products! (Reset before appending)
                            litProductDetails.Text += $@"
                    <p><strong>Product Name:</strong> {reader["Name"]}</p>
                    <p><strong>Quantity:</strong> {reader["TotalQuantity"]}</p>
                    <p><strong>Price Per Unit:</strong> ₹{reader["Price"]}</p>
                    <p><strong>Total Price:</strong> ₹{reader["TotalFinalAmount"]}</p>
                    <hr>"; // Separating multiple products visually

                            // Add to total amount
                            totalAmount += Convert.ToDecimal(reader["TotalFinalAmount"]);

                            // Store payment method (assuming all products in one order use the same method)
                            if (string.IsNullOrEmpty(paymentMethod))
                            {
                                paymentMethod = reader["payment_method"].ToString();
                            }
                        }
                        reader.Close();
                    }
                }

                // Display final amount at the bottom
                litTotalAmount.Text = $"<p><strong>Final Amount:</strong> ₹{totalAmount}</p>";

                // ✅ Fix: Check if payment method exists in dropdown before setting value
                if (!string.IsNullOrEmpty(paymentMethod) && ddlPaymentMethod.Items.FindByValue(paymentMethod) != null)
                {
                    ddlPaymentMethod.SelectedValue = paymentMethod;
                }
            }
        }



        protected void ddlPaymentMethod_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["PurchasedProductIds"] == null || Session["UserId"] == null)
            {
                Response.Write("<script>alert('Error: User ID or Purchased Products are missing!');</script>");
                return;
            }

            List<int> productIds = (List<int>)Session["PurchasedProductIds"];
            int userId = Convert.ToInt32(Session["UserId"]); // ✅ Retrieve user ID properly
            string selectedPaymentMethod = ddlPaymentMethod.SelectedValue;

            if (string.IsNullOrEmpty(selectedPaymentMethod))
            {
                Response.Write("<script>alert('Please select a valid payment method!');</script>");
                return;
            }

            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                foreach (int productId in productIds.Distinct()) // ✅ Prevent duplicate updates
                {
                    string updateQuery = @"
            UPDATE PurchaseData 
            SET payment_method = @PaymentMethod
            WHERE product_id = @ProductId AND user_id = @UserId";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@PaymentMethod", selectedPaymentMethod);
                        cmd.Parameters.AddWithValue("@ProductId", productId);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            //Response.Write("<script>alert('Payment Method Updated Successfully!');</script>");
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            string script = "window.print(); setTimeout(function() { window.location='Index.aspx'; }, 8000);";
            ClientScript.RegisterStartupScript(this.GetType(), "PrintAndRedirect", script, true);
        }





        // Auto-print receipt after payment method is selected
        //ClientScript.RegisterStartupScript(this.GetType(), "Print", "window.print();", true);
    }

}


