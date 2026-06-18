using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.IO;

namespace UrbanKicks.admin
{
    public partial class AddProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text) ||
                string.IsNullOrWhiteSpace(txtBrand.Text) ||
                string.IsNullOrWhiteSpace(txtDescription.Text))
            {
                Response.Write("<script>alert('Please fill in all the required fields.');</script>");
                return;
            }

            if (!decimal.TryParse(txtPrice.Text, out decimal price))
            {
                Response.Write("<script>alert('Invalid numeric input. Please enter valid numbers.');</script>");
                return;
            }

            // Handling Image Uploads
            string imagePath1 = UploadImage(FileUpload1);
            string imagePath2 = UploadImage(FileUpload2);
            string imagePath3 = UploadImage(FileUpload3);

            if (string.IsNullOrEmpty(imagePath1))
            {
                Response.Write("<script>alert('Please upload at least one image.');</script>");
                return;
            }

            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"INSERT INTO Products  (Name, Brand, Price, Description, ImageUrl, ImageUrl2, ImageUrl3) 
                                 VALUES  (@Name, @Brand, @Price, @Description, @ImageUrl, @ImageUrl2, @ImageUrl3)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Brand", txtBrand.Text.Trim());
                    cmd.Parameters.AddWithValue("@Price", price);
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
                    cmd.Parameters.AddWithValue("@ImageUrl", (object)imagePath1 ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@ImageUrl2", (object)imagePath2 ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@ImageUrl3", (object)imagePath3 ?? DBNull.Value);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                        Response.Redirect("Dashboard.aspx");
                    }
                    catch (Exception ex)
                    {
                        Response.Write($"<script>alert('Error: {ex.Message}');</script>");
                    }
                }
            }
        }

        private string UploadImage(FileUpload fileUpload)
        {
            if (fileUpload.HasFile)
            {
                string folderPath = Server.MapPath("~/images/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(fileUpload.FileName);
                string filePath = Path.Combine(folderPath, fileName);
                fileUpload.SaveAs(filePath);

                return fileName; // Only returning filename instead of "~/images/filename.jpg"
            }
            return null;
        }

    }
}
