
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace UrbanKicks
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ProductID"] != null)
                {
                    string productId = Session["ProductID"].ToString();

                    // Check if the product is already in the cart
                    List<CartItem> cart = Session["cart"] as List<CartItem> ?? new List<CartItem>();
                    if (!cart.Any(p => p.ProductId == productId))
                    {
                        AddToCart(productId);
                    }

                    // Clear the session so it doesn't add the same product multiple times
                    Session.Remove("ProductID");
                    Session.Remove("ProductSize");
                }

                LoadCart();
            }
        }


        private void AddToCart(string productId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, Name, Brand, Price, ImageUrl2 FROM Products WHERE Id = @Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", productId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    CartItem newItem = new CartItem
                    {
                        ProductId = reader["Id"].ToString(),
                        ProductName = reader["Name"].ToString(),
                        Brand = reader["Brand"].ToString(),
                        Price = Convert.ToDecimal(reader["Price"]),
                        ImageUrl = "images/" + reader["ImageUrl2"].ToString(),
                        Quantity = 1,
                        Size = Session["ProductSize"]?.ToString() ?? "Not Selected"
                    };

                    List<CartItem> cart = Session["cart"] as List<CartItem> ?? new List<CartItem>();

                    cart.Add(newItem);
                    Session["cart"] = cart;
                    ((User)Master).UpdateCartCount();
                    LoadCart();
                }
            }
        }

        private void LoadCart()
        {
            List<CartItem> cartsession = Session["cart"] as List<CartItem>;

            if (cartsession != null && cartsession.Count > 0)
            {
                rptCart.DataSource = cartsession;
                rptCart.DataBind();

                // **Calculate Grand Total**
                decimal grandTotal = cartsession.Sum(item => item.Price * item.Quantity);

                // **Display Grand Total**
                lblGrandTotal.Text = "₹" + grandTotal.ToString("N2");

                cartPanel.Visible = true;
                litCartMessage.Text = "";
            }
            else
            {
                cartPanel.Visible = false;
                //litCartMessage.Text = "<div class='empty-cart-message'>Your cart is empty</div>";
                litCartMessage.Text = @"
            <div class='empty-cart-message'>
                Your cart is empty
                <br />
                <a href='Index.aspx' class='btn btn-primary' style='margin-top: 10px; display: inline-block;'>Continue Shopping</a>
            </div>";
            }
        }


        //protected void btnCheckout_Click(object sender, EventArgs e)
        //{
        //    if (Session["Username"] == null)
        //    {
        //        Response.Redirect("SignIn.aspx");
        //    }
        //    else
        //    {
        //        Response.Redirect("Checkout.aspx");
        //    }


        //}


        protected void ddlQuantity_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            RepeaterItem item = (RepeaterItem)ddl.NamingContainer;
            HiddenField hdnProductId = (HiddenField)item.FindControl("hdnProductId");
            string productId = hdnProductId.Value;
            int quantity = int.Parse(ddl.SelectedValue);

            List<CartItem> cart = Session["cart"] as List<CartItem>;
            if (cart != null)
            {
                CartItem selectedItem = cart.FirstOrDefault(p => p.ProductId == productId);
                if (selectedItem != null)
                {
                    selectedItem.Quantity = quantity;
                }

                //Update session with the modified cart
                Session["cart"] = cart;
                // Refresh the cart display after updating quantity
                LoadCart();
            }

        }

        protected void rptCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {

                CartItem item = (CartItem)e.Item.DataItem;

                        // Find the quantity dropdown and set its value
                        DropDownList ddlQuantity = (DropDownList)e.Item.FindControl("ddlQuantity");
                        if (ddlQuantity != null)
                        {
                            ddlQuantity.SelectedValue = item.Quantity.ToString();
                        }
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
            HiddenField hdnProductId = (HiddenField)item.FindControl("hdnProductId");
            string productId = hdnProductId.Value;

            List<CartItem> cart = Session["cart"] as List<CartItem>;
            if (cart != null)
            {
                CartItem itemToRemove = cart.FirstOrDefault(p => p.ProductId == productId);
                if (itemToRemove != null)
                {
                    cart.Remove(itemToRemove);
                }

                // Update session with modified cart
                Session["cart"] = cart;
                ((User)Master).UpdateCartCount();

                // Refresh cart display
                LoadCart();
                UpdateGrandTotal(); // Call method to update grand total dynamically
            }
        }

        // Method to update the Grand Total dynamically
        private void UpdateGrandTotal()
        {
            List<CartItem> cart = Session["cart"] as List<CartItem>;
            decimal grandTotal = cart?.Sum(p => p.Price * p.Quantity) ?? 0;

            lblGrandTotal.Text = "₹" + grandTotal.ToString("N2"); // Update Grand Total Label
        }


        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("SignIn.aspx");
                return;
            }

            string username = Session["Username"].ToString();
            int userId = GetUserId(username); // Get user ID from DB

            if (userId == -1) // If user ID is not found, handle the error
            {
                litCartMessage.Text = "<div class='error-message'>User not found.</div>";
                return;
            }

            List<CartItem> cart = Session["cart"] as List<CartItem>;
            if (cart != null && cart.Count > 0)
            {
                string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
                List<int> purchasedProductIds = new List<int>(); // To store product IDs

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    using (SqlTransaction transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            foreach (var item in cart)
                            {
                                string insertQuery = @"
                            INSERT INTO PurchaseData (user_id, product_id, date_of_purchase, quantity, final_total, payment_method)
                            VALUES (@UserId, @ProductId, GETDATE(), @Quantity, @FinalTotal, NULL)";

                                using (SqlCommand cmd = new SqlCommand(insertQuery, conn, transaction))
                                {
                                    cmd.Parameters.AddWithValue("@UserId", userId);
                                    cmd.Parameters.AddWithValue("@ProductId", item.ProductId);
                                    cmd.Parameters.AddWithValue("@Quantity", item.Quantity);
                                    cmd.Parameters.AddWithValue("@FinalTotal", item.Quantity * item.Price);

                                    cmd.ExecuteNonQuery();
                                }

                                // Add the product ID to the list for session storage
                               purchasedProductIds.Add(Convert.ToInt32(item.ProductId));

                            }

                            transaction.Commit();
                            Session["UserId"] = userId;
                            // Store the product IDs in the session for Checkout page retrieval
                            Session["PurchasedProductIds"] = purchasedProductIds;

                            // Clear cart and update UI
                            Session["cart"] = null;
                            ((User)Master).UpdateCartCount(); // Update cart count in UI

                            Response.Redirect("Checkout.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                        }
                        catch (Exception ex)
                        {
                            transaction.Rollback();
                            litCartMessage.Text = $"<div class='error-message'>Error processing checkout: {ex.Message}</div>";
                        }
                    }
                }
            }
            else
            {
                litCartMessage.Text = "<div class='error-message'>Your cart is empty.</div>";
            }
        }



        //  Context.ApplicationInstance.CompleteRequest();
        // Method to get user ID from Username
        private int GetUserId(string username)
        {
            Context.ApplicationInstance.CompleteRequest();
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id FROM Users WHERE username = @Username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);

                conn.Open();
                object result = cmd.ExecuteScalar();

                return result != null ? Convert.ToInt32(result) : -1;
            }
        }



        public class CartItem
        {
            public string ProductId { get; set; }
            public string ProductName { get; set; }
            public string Brand { get; set; }
            public decimal Price { get; set; }
            public string ImageUrl { get; set; }
            public int Quantity { get; set; } = 1;
            public string Size { get; set; }
        }
    }
}




//---------------------------------------------------------------------------------------------------------------------------------------


    
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Data.SqlClient;
//using System.Configuration;
//using System.Data;

//namespace UrbanKicks
//{
//    public partial class Cart : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                if (Session["ProductID"] != null)
//                {
//                    string productId = Session["ProductID"].ToString();

//                    // Check if the product is already in the cart
//                    List<CartItem> cart = Session["cart"] as List<CartItem> ?? new List<CartItem>();
//                    if (!cart.Any(p => p.ProductId == productId))
//                    {
//                        AddToCart(productId);
//                    }

//                    // Clear the session so it doesn't add the same product multiple times
//                    Session.Remove("ProductID");
//                    Session.Remove("ProductSize");
//                }

//                LoadCart();
//            }
//        }


//        private void AddToCart(string productId)
//        {
//            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
//            using (SqlConnection conn = new SqlConnection(connStr))
//            {
//                string query = "SELECT Id, Name, Brand, Price, ImageUrl2 FROM Products WHERE Id = @Id";
//                SqlCommand cmd = new SqlCommand(query, conn);
//                cmd.Parameters.AddWithValue("@Id", productId);

//                conn.Open();
//                SqlDataReader reader = cmd.ExecuteReader();
//                if (reader.Read())
//                {
//                    CartItem newItem = new CartItem
//                    {
//                        ProductId = reader["Id"].ToString(),
//                        ProductName = reader["Name"].ToString(),
//                        Brand = reader["Brand"].ToString(),
//                        Price = Convert.ToDecimal(reader["Price"]),
//                        ImageUrl = "images/" + reader["ImageUrl2"].ToString(),
//                        Quantity = 1,
//                        Size = Session["ProductSize"]?.ToString() ?? "Not Selected"
//                    };

//                    List<CartItem> cart = Session["cart"] as List<CartItem> ?? new List<CartItem>();

//                    cart.Add(newItem);
//                    Session["cart"] = cart;
//                    ((User)Master).UpdateCartCount();
//                    LoadCart();
//                }
//            }
//        }

//        private void LoadCart()
//        {
//            List<CartItem> cartsession = Session["cart"] as List<CartItem>;

//            if (cartsession != null && cartsession.Count > 0)
//            {
//                rptCart.DataSource = cartsession;
//                rptCart.DataBind();

//                // **Calculate Grand Total**
//                decimal grandTotal = cartsession.Sum(item => item.Price * item.Quantity);

//                // **Display Grand Total**
//                lblGrandTotal.Text = "₹" + grandTotal.ToString("N2");

//                cartPanel.Visible = true;
//                litCartMessage.Text = "";
//            }
//            else
//            {
//                cartPanel.Visible = false;
//                //litCartMessage.Text = "<div class='empty-cart-message'>Your cart is empty</div>";
//                litCartMessage.Text = @"
//            <div class='empty-cart-message'>
//                Your cart is empty
//                <br />
//                <a href='Index.aspx' class='btn btn-primary' style='margin-top: 10px; display: inline-block;'>Continue Shopping</a>
//            </div>";
//            }
//        }


//        protected void btnCheckout_Click(object sender, EventArgs e)
//        {
//            if (Session["Username"] == null)
//            {
//                Response.Redirect("SignIn.aspx");
//            }
//            else
//            {
//                Response.Redirect("Checkout.aspx");
//            }
//        }


//        protected void ddlQuantity_SelectedIndexChanged(object sender, EventArgs e)
//        {
//            DropDownList ddl = (DropDownList)sender;
//            RepeaterItem item = (RepeaterItem)ddl.NamingContainer;
//            HiddenField hdnProductId = (HiddenField)item.FindControl("hdnProductId");
//            string productId = hdnProductId.Value;
//            int quantity = int.Parse(ddl.SelectedValue);

//            List<CartItem> cart = Session["cart"] as List<CartItem>;
//            if (cart != null)
//            {
//                CartItem selectedItem = cart.FirstOrDefault(p => p.ProductId == productId);
//                if (selectedItem != null)
//                {
//                    selectedItem.Quantity = quantity;
//                }

//                //Update session with the modified cart
//                Session["cart"] = cart;
//                // Refresh the cart display after updating quantity
//                LoadCart();
//            }

//        }

//        protected void rptCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
//        {
//            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
//            {

//                CartItem item = (CartItem)e.Item.DataItem;

//                // Find the quantity dropdown and set its value
//                DropDownList ddlQuantity = (DropDownList)e.Item.FindControl("ddlQuantity");
//                if (ddlQuantity != null)
//                {
//                    ddlQuantity.SelectedValue = item.Quantity.ToString();
//                }
//            }
//        }

//        protected void btnRemove_Click(object sender, EventArgs e)
//        {
//            Button btn = (Button)sender;
//            RepeaterItem item = (RepeaterItem)btn.NamingContainer;
//            HiddenField hdnProductId = (HiddenField)item.FindControl("hdnProductId");
//            string productId = hdnProductId.Value;

//            List<CartItem> cart = Session["cart"] as List<CartItem>;
//            if (cart != null)
//            {
//                CartItem itemToRemove = cart.FirstOrDefault(p => p.ProductId == productId);
//                if (itemToRemove != null)
//                {
//                    cart.Remove(itemToRemove);
//                }

//                // Update session with modified cart
//                Session["cart"] = cart;
//                ((User)Master).UpdateCartCount();

//                // Refresh cart display
//                LoadCart();
//                UpdateGrandTotal(); // Call method to update grand total dynamically
//            }
//        }

//        // Method to update the Grand Total dynamically
//        private void UpdateGrandTotal()
//        {
//            List<CartItem> cart = Session["cart"] as List<CartItem>;
//            decimal grandTotal = cart?.Sum(p => p.Price * p.Quantity) ?? 0;

//            lblGrandTotal.Text = "₹" + grandTotal.ToString("N2"); // Update Grand Total Label
//        }



//        public class CartItem
//        {
//            public string ProductId { get; set; }
//            public string ProductName { get; set; }
//            public string Brand { get; set; }
//            public decimal Price { get; set; }
//            public string ImageUrl { get; set; }
//            public int Quantity { get; set; } = 1;
//            public string Size { get; set; }
//        }
//    }
//}