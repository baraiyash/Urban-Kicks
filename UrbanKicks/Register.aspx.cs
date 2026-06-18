using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace UrbanKicks
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            // Connection String from Web.config
            string connStr = ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // SQL Insert Query
                string query = "INSERT INTO Users (username, password, fname, lname, phone, dob, email) " +
                               "VALUES (@Username, @Password, @FirstName, @LastName, @Phone, @DOB, @Email)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add Parameters to prevent SQL Injection
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@LastName", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Phone", txtMobile.Text.Trim());
                    cmd.Parameters.AddWithValue("@DOB", txtDOB.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // Success Message
                        Response.Write("<script>alert('Registration Successful! You can now sign in.');</script>");

                        // Redirect to SignIn Page
                        Response.Redirect("SignIn.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('Registration Failed. Please try again.');</script>");
                    }
                }
            }
        }
    }
}