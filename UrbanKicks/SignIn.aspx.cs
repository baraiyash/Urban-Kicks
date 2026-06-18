using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace UrbanKicks
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    LoadUserProfile(Session["Username"].ToString());
                }
                else
                {
                    pnlSignIn.Visible = true;
                    pnlUserProfile.Visible = false;
                }
            }
        }
            
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter both Username and Password.";
                lblError.Visible = true;
                ShowErrorPopup();
                txtUsername.Text = ""; // ✅ Clear Username
                txtPassword.Text = ""; // ✅ Clear Password
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT username FROM Users WHERE username = @Username AND password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    Session["Username"] = username; // ✅ Store user session properly

                    // ✅ Ch eck if user was redirected from another page
                    string returnUrl = Request.QueryString["returnUrl"];

                    if (!string.IsNullOrEmpty(returnUrl))
                    {
                        Response.Redirect(returnUrl); // ✅ Redirect back to the page user came from
                    }
                    else
                    {
                        Response.Redirect("Index.aspx"); // ✅ Default to Index if no return URL
                    }
                }
                else
                {
                    lblError.Text = "Invalid Username or Password!";
                    lblError.Visible = true;
                    ShowErrorPopup();
                    txtUsername.Text = "";
                    txtPassword.Text = "";
                }
                reader.Close();
            }
        }

        private void ShowErrorPopup()
        {
            string script = @"
        var errorLabel = document.getElementById('" + lblError.ClientID + @"');
        if (errorLabel) {
            errorLabel.classList.add('show'); // ✅ Ensures it's centered
            setTimeout(function() {
                errorLabel.classList.remove('show'); // ✅ Hides after 3 seconds
            }, 3000);
        }
    ";
            ScriptManager.RegisterStartupScript(this, GetType(), "HideError", script, true);
        }

        private void LoadUserProfile(string username)
        {
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT username, fname, lname, phone, dob, email FROM Users WHERE username = @Username";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblUsername.Text = reader["username"].ToString();
                    lblFirstName.Text = reader["fname"].ToString();
                    lblLastName.Text = reader["lname"].ToString();
                    lblPhone.Text = reader["phone"].ToString();
                    lblDOB.Text = Convert.ToDateTime(reader["dob"]).ToString("MMMM dd, yyyy");
                    lblEmail.Text = reader["email"].ToString();

                    pnlSignIn.Visible = false;
                    pnlUserProfile.Visible = true;
                }
                reader.Close();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear(); // Clear all session variables
            Response.Redirect("Index.aspx");
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }
    }
}



//-----------------------------------------------------------------------------------------------------------------------------------
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Data.SqlClient;
//using System.Configuration;

//namespace UrbanKicks
//{
//    public partial class SignIn : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {

//            if (Session["ProductID"] != null)
//            {
//                string productId = Session["ProductID"].ToString();
//                string productName = Session["ProductName"].ToString();
//                string productPrice = Session["ProductPrice"].ToString();
//                string productImage = Session["ProductImage"].ToString();
//                string selectedSize = Session["SelectedProductSize"]?.ToString() ?? "Not Selected";

//                // Display product details
//                lblProductName.Text = productName;
//                lblProductPrice.Text = productPrice;
//                imgProduct.ImageUrl = productImage;
//                lblSelectedSize.Text = selectedSize;
//            }
//            else
//            {
//                Response.Write("<h2>No product selected!</h2>");
//            }
//        }

//        protected void btnSubmit_Click(object sender, EventArgs e)
//        {
//            string username = txtUsername.Text.Trim();
//            string password = txtPassword.Text.Trim();

//            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
//            {
//                lblError.Text = "Please enter both Username and Password.";
//                lblError.Visible = true;
//                return;
//            }

//            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
//            using (SqlConnection conn = new SqlConnection(connStr))
//            {
//                string query = "SELECT username FROM Users WHERE username = @Username AND password = @Password";
//                SqlCommand cmd = new SqlCommand(query, conn);
//                cmd.Parameters.AddWithValue("@Username", username);
//                cmd.Parameters.AddWithValue("@Password", password);

//                conn.Open();
//                SqlDataReader reader = cmd.ExecuteReader();
//                if (reader.HasRows)
//                {
//                    // Preserve cart session
//                    List<CartItem> existingCart = Session["cart"] as List<CartItem>;

//                    // Preserve product details, ensuring they're not null
//                    string productId = Session["ProductID"] as string ?? "";
//                    string productName = Session["ProductName"] as string ?? "";
//                    string productPrice = Session["ProductPrice"] as string ?? "";
//                    string productImage = Session["ProductImage"] as string ?? "";
//                    string productSize = Session["ProductSize"] as string ?? "";

//                    // Clear all session except cart & product details
//                    Session.Clear();
//                    Session["Username"] = username;

//                    if (existingCart != null)
//                    {
//                        Session["cart"] = existingCart;
//                    }

//                    // Restore product details in session
//                    Session["ProductID"] = productId;
//                    Session["ProductName"] = productName;
//                    Session["ProductPrice"] = productPrice;
//                    Session["ProductImage"] = productImage;
//                    Session["ProductSize"] = productSize;

//                    conn.Close();
//                    Response.Redirect("Cart.aspx");
//                }
//                else
//                {
//                    lblError.Text = "Invalid Username or Password!";
//                    lblError.Visible = true;
//                }
//                reader.Close();
//                conn.Close();
//            }
//        }

//        protected void btnRegister_Click(object sender, EventArgs e)
//        {
//            Response.Redirect("Register.aspx");
//        }
//    }
//}
