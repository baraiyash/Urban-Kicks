using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace UrbanKicks
{
    public partial class Product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["Id"] != null && int.TryParse(Request.QueryString["Id"], out int productId))
                {
                    LoadProduct(productId);
                    LoadProductImages(productId);
                }
                else
                {
                    Response.Write("<h2>Product not found!</h2>");
                }
            }
        }

        private void LoadProduct(int productId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"]?.ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Products WHERE Id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", productId);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblProductName.Text = reader["Name"].ToString();
                            lblProductPrice.Text = "₹" + Convert.ToDecimal(reader["Price"]).ToString("N2");
                            lblProductBrand.Text = reader["Brand"].ToString();
                            lblProductDescription.Text = reader["Description"].ToString();
                            ImageProduct.ImageUrl = "images/" + reader["ImageUrl"].ToString();
                        }
                        else
                        {
                            Response.Write("<h2>Product not found!</h2>");
                        }
                    }
                }
            }
        }

        private void LoadProductImages(int productId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"]?.ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT ImageUrl, ImageUrl2, ImageUrl3 FROM Products WHERE Id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", productId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        DataTable dt = new DataTable();
                        dt.Columns.Add("ImageUrl");

                        if (reader.Read())
                        {
                            if (!string.IsNullOrEmpty(reader["ImageUrl"].ToString())) dt.Rows.Add("images/" + reader["ImageUrl"].ToString());
                            if (!string.IsNullOrEmpty(reader["ImageUrl2"].ToString())) dt.Rows.Add("images/" + reader["ImageUrl2"].ToString());
                            if (!string.IsNullOrEmpty(reader["ImageUrl3"].ToString())) dt.Rows.Add("images/" + reader["ImageUrl3"].ToString());
                        }

                        ImageRepeater.DataSource = dt;
                        ImageRepeater.DataBind();
                    }
                }
            }
        }

        protected void BtnAddToBag_Click(object sender, EventArgs e)
        {
            string selectedProductId = Request.QueryString["Id"]; // Get the product ID from URL
            string selectedSize = ddlSize.SelectedValue; // Get selected size



            if (Session["Username"] == null)
            {
                if (!string.IsNullOrEmpty(selectedProductId))
                {
                    // Update session with the new product ID
                    Session["ProductID"] = selectedProductId;
                    Session["ProductSize"] = selectedSize;
                    Response.Redirect("SignIn.aspx?returnUrl=Cart.aspx");
                }
            }
            else
            {
                Session["ProductID"] = selectedProductId;
                Session["ProductSize"] = selectedSize;
                // Redirect to Cart.aspx
                Response.Redirect("Cart.aspx");
            }
        }


        //protected void BtnAddToBag_Click(object sender, EventArgs e)
        //{

        //    if (Session["Username"] == null)
        //    {
        //        Session["ProductID"] = selectedProductId;
        //        Session["ProductSize"] = ddlSize.SelectedValue;
        //        Response.Redirect("SignIn.aspx");
        //    }
        //    else
        //    {
        //        Response.Redirect("Cart.aspx");
        //    }
        //}
    }
}


//----------------------------------------------------------------------------------------------------------------------------------

//using System;
//using System.Data;
//using System.Data.SqlClient;
//using System.Configuration;
//using System.Collections.Generic;

//namespace UrbanKicks
//{
//    public partial class Product : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                // You can load the product details dynamically from the database here (optional)
//                if (Request.QueryString["Id"] != null)
//                {
//                    int productIdInt;
//                    if (int.TryParse(Request.QueryString["Id"], out productIdInt))
//                    {
//                        LoadProduct(productIdInt);
//                        LoadProductImages(productIdInt);
//                    }
//                    else
//                    {
//                        Response.Write("<h2>Invalid Product ID!</h2>");
//                    }
//                }
//                else
//                {
//                    Response.Write("<h2>Product not found!</h2>");
//                }
//            }
//        }

//        private void LoadProduct(int productId)
//        {
//            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"]?.ConnectionString;

//            if (string.IsNullOrEmpty(connStr))
//            {
//                throw new Exception("Connection string 'UrbanKicksDB' is missing from web.config.");
//            }

//            using (SqlConnection conn = new SqlConnection(connStr))
//            {
//                string query = "SELECT * FROM Products WHERE Id = @Id";
//                using (SqlCommand cmd = new SqlCommand(query, conn))
//                {
//                    cmd.Parameters.AddWithValue("@Id", productId);
//                    conn.Open();

//                    using (SqlDataReader reader = cmd.ExecuteReader())
//                    {
//                        if (reader.Read())
//                        {
//                            lblProductName.Text = reader["Name"].ToString();
//                            lblProductPrice.Text = "₹" + Convert.ToDecimal(reader["Price"]).ToString("N2");
//                            lblProductBrand.Text = reader["Brand"].ToString();
//                            lblProductDescription.Text = reader["Description"].ToString();
//                            ImageProduct.ImageUrl = "images/" + reader["ImageUrl"].ToString();

//                            // Store product details in session
//                            Session["ProductID"] = reader["Id"].ToString();
//                            Session["ProductName"] = reader["Name"].ToString();
//                            Session["ProductBrand"] = reader["Brand"].ToString();
//                            Session["ProductPrice"] = "₹" + Convert.ToDecimal(reader["Price"]).ToString("N2");
//                            Session["ProductImage"] = "images/" + reader["ImageUrl"].ToString();
//                        }
//                        else
//                        {
//                            Response.Write("<h2>Product not found!</h2>");
//                        }
//                    }
//                }
//            }
//        }

//        private void LoadProductImages(int productId)
//        {
//            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"]?.ConnectionString;

//            if (string.IsNullOrEmpty(connStr))
//            {
//                throw new Exception("Connection string 'UrbanKicksDB' is missing from web.config.");
//            }

//            using (SqlConnection conn = new SqlConnection(connStr))
//            {
//                string query = "SELECT ImageUrl, ImageUrl2, ImageUrl3 FROM Products WHERE Id = @Id";
//                using (SqlCommand cmd = new SqlCommand(query, conn))
//                {
//                    cmd.Parameters.AddWithValue("@Id", productId);
//                    conn.Open();

//                    using (SqlDataReader reader = cmd.ExecuteReader())
//                    {
//                        DataTable dt = new DataTable();
//                        dt.Columns.Add("ImageUrl"); // Ensure column name matches exactly

//                        if (reader.Read())
//                        {
//                            if (!string.IsNullOrEmpty(reader["ImageUrl"].ToString()))
//                            {
//                                dt.Rows.Add("images/" + reader["ImageUrl"].ToString());
//                            }
//                            if (!string.IsNullOrEmpty(reader["ImageUrl2"].ToString()))
//                            {
//                                dt.Rows.Add("images/" + reader["ImageUrl2"].ToString());
//                            }
//                            if (!string.IsNullOrEmpty(reader["ImageUrl3"].ToString()))
//                            {
//                                dt.Rows.Add("images/" + reader["ImageUrl3"].ToString());
//                            }
//                        }

//                        ImageRepeater.DataSource = dt;
//                        ImageRepeater.DataBind();
//                    }
//                }
//            }
//        }

//        protected void BtnAddToBag_Click(object sender, EventArgs e)
//        {
//            if (Session["Username"] == null)
//            {
//                Response.Redirect("SignIn.aspx");
//            }
//            else
//            {
//                if (ddlSize.SelectedValue == "")
//                {
//                    Response.Write("<script>alert('Please select a size before adding to cart!');</script>");
//                    return;
//                }

//                // Get selected size from dropdown
//                string selectedSize = ddlSize.SelectedValue;

//                // Create a new product object to store in the cart
//                var product = new
//                {
//                    ProductID = Session["ProductID"].ToString(),
//                    ProductName = Session["ProductName"].ToString(),
//                    ProductBrand = Session["ProductBrand"].ToString(),
//                    ProductPrice = Session["ProductPrice"].ToString(),
//                    ProductImage = Session["ProductImage"].ToString(),
//                    SelectedSize = selectedSize
//                };

//                // Retrieve the cart from session or create a new one
//                List<dynamic> cart = (List<dynamic>)Session["Cart"];
//                if (cart == null)
//                {
//                    cart = new List<dynamic>(); // Initialize a new cart if it doesn't exist
//                }

//                // Add the new product to the cart
//                cart.Add(product);

//                // Store the updated cart back in the session
//                Session["Cart"] = cart;

//                // Redirect to Cart page
//                Response.Redirect("Cart.aspx");
//            }
//        }

//    }
//}


//-------------------------------------------------------------------------------------------------------------------------------------------


//using System;
//using System.Data;
//using System.Data.SqlClient;
//using System.Configuration;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Collections.Generic;

//namespace UrbanKicks
//{
//    public partial class Product : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                if (int.TryParse(Request.QueryString["id"], out int productId))
//                {
//                    LoadProductDetails(productId);
//                }
//                else
//                {
//                    lblName.Text = "Invalid product ID.";
//                }
//            }
//        }

//        protected void btnAddToBag_Click(object sender, EventArgs e)
//        {
//            if (int.TryParse(Request.QueryString["id"], out int productId))
//            {
//                string selectedSize = ddlSize.SelectedValue; // Get selected size

//                // Redirect to Cart.aspx
//                Response.Redirect("Cart.aspx");
//            }
//        }

//        private void LoadProductDetails(int productId)
//        {
//            string connectionString = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;

//            using (SqlConnection conn = new SqlConnection(connectionString))
//            {
//                string query = "SELECT Name, Brand, Price, Description, ImageUrl, ImageUrl2, ImageUrl3 FROM Products WHERE Id = @Id";

//                using (SqlCommand cmd = new SqlCommand(query, conn))
//                {
//                    cmd.Parameters.AddWithValue("@Id", productId);

//                    try
//                    {
//                        conn.Open();
//                        using (SqlDataReader reader = cmd.ExecuteReader())
//                        {
//                            if (reader.Read())
//                            {
//                                lblName.Text = reader["Name"].ToString();
//                                lblBrand.Text = reader["Brand"].ToString();
//                                lblPrice.Text = Convert.ToDecimal(reader["Price"]).ToString("N2");
//                                lblDescription.Text = reader["Description"].ToString();

//                                // Set product image
//                                string imageFolderPath = "images/";
//                                imgProduct.ImageUrl = GetImageUrl(reader["ImageUrl"].ToString(), imageFolderPath);

//                                // Load additional images in the repeater
//                                LoadAdditionalImages(reader, imageFolderPath);
//                            }
//                            else
//                            {
//                                lblName.Text = "Product not found.";
//                            }
//                        }
//                    }
//                    catch (Exception ex)
//                    {
//                        lblName.Text = "Error loading product details.";
//                        // Log error (consider using a logging framework)
//                    }
//                }
//            }
//        }

//        private string GetImageUrl(string imageName, string folderPath)
//        {
//            return !string.IsNullOrEmpty(imageName) ? folderPath + imageName : "images/default.jpg";
//        }

//        private void LoadAdditionalImages(SqlDataReader reader, string folderPath)
//        {
//            DataTable dtImages = new DataTable();
//            dtImages.Columns.Add("ImageUrl");

//            string[] imageColumns = { "ImageUrl", "ImageUrl2", "ImageUrl3" };

//            foreach (string column in imageColumns)
//            {
//                if (!string.IsNullOrEmpty(reader[column].ToString()))
//                {
//                    dtImages.Rows.Add(folderPath + reader[column].ToString());
//                }
//            }

//            rptImages.DataSource = dtImages;
//            rptImages.DataBind();
//        }
//    }
//}

