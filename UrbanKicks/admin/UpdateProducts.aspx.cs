using System;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanKicks.admin
{
    public partial class UpdateProducts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["Id"] != null)
                {
                    int productid;
                    if (int.TryParse(Request.QueryString["Id"], out productid))
                    {
                        LoadProductDetails(productid);
                    }
                    else
                    {
                        litMessage.Text = "<div class='alert alert-danger'>Invalid Product ID.</div>";
                    }
                }
                else
                {
                    litMessage.Text = "<div class='alert alert-danger'>Product ID is missing.</div>";
                }
            }
        }

        private void LoadProductDetails(int productId)
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Products WHERE Id = @ID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", productId);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtProductId.Text = reader["Id"].ToString();
                        txtName.Text = reader["Name"].ToString();
                        txtBrand.Text = reader["Brand"].ToString();
                        txtPrice.Text = reader["Price"].ToString();
                        txtDescription.Text = reader["Description"].ToString();

                        // Load images only if a new one hasn't been selected
                        if (!IsPostBack)
                        {
                            imgPreview1.ImageUrl = "~/images/" + reader["ImageUrl"].ToString();
                            imgPreview2.ImageUrl = "~/images/" + reader["ImageUrl2"].ToString();
                            imgPreview3.ImageUrl = "~/images/" + reader["ImageUrl3"].ToString();
                        }

                        ViewState["OldImage1"] = reader["ImageUrl"].ToString();
                        ViewState["OldImage2"] = reader["ImageUrl2"].ToString();
                        ViewState["OldImage3"] = reader["ImageUrl3"].ToString();
                    }
                    else
                    {
                        litMessage.Text = "<div class='alert alert-danger'>Product not found.</div>";
                    }
                    conn.Close();
                }
            }
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["UrbanKicksDB"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "UPDATE Products SET Name = @ProductName, Brand = @Brand, Price = @Price, Description = @Description, ImageUrl = @Image1, ImageUrl2 = @Image2, ImageUrl3 = @Image3 WHERE Id = @ProductId";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ProductId", Convert.ToInt32(txtProductId.Text));
                    cmd.Parameters.AddWithValue("@ProductName", txtName.Text);
                    cmd.Parameters.AddWithValue("@Brand", txtBrand.Text);
                    cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text));
                    cmd.Parameters.AddWithValue("@Description", txtDescription.Text);

                    // Image Upload Logic with Deletion
                    cmd.Parameters.AddWithValue("@Image1", UploadImage(fileUpload1, ViewState["OldImage1"].ToString()));
                    cmd.Parameters.AddWithValue("@Image2", UploadImage(fileUpload2, ViewState["OldImage2"].ToString()));
                    cmd.Parameters.AddWithValue("@Image3", UploadImage(fileUpload3, ViewState["OldImage3"].ToString()));

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    Response.Redirect("ManageProducts.aspx");
                }
            }
        }

        private string UploadImage(FileUpload fileUpload, string oldImageName)
        {
            if (fileUpload.HasFile)
            {
                string filename = Path.GetFileName(fileUpload.FileName);
                string savePath = Server.MapPath("~/images/") + filename;

                string oldImagePath = Server.MapPath("~/images/") + oldImageName;
                if (File.Exists(oldImagePath))
                {
                    File.Delete(oldImagePath);
                }

                fileUpload.SaveAs(savePath);
                return filename;
            }
            return oldImageName;
        }
    }
}
