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
    public partial class LoginAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                string query = "SELECT username FROM AdminLogin WHERE username = @Username AND password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {
                    Session["Username"] = username;

                    string returnUrl = Request.QueryString["returnUrl"];
                    if (!string.IsNullOrEmpty(returnUrl))
                    {
                        Response.Redirect(returnUrl);
                    }
                    else
                    {
                        Response.Redirect("admin/Dashboard.aspx");
                    }
                }
                else
                {
                    lblError.Text = "Invalid Username or Password!";
                    lblError.Visible = true;
                    ShowErrorPopup();

                    txtUsername.Text = ""; // ✅ Clear Username
                    txtPassword.Text = ""; // ✅ Clear Password
                }
                reader.Close();
            }
        }


        // ✅ Injects JavaScript to hide error after 3 seconds
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

    }
}