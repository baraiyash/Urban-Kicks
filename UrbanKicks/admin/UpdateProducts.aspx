<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="UpdateProducts.aspx.cs" Inherits="UrbanKicks.admin.UpdateProducts" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section">
        <div class="container-fluid">
            <div class="title-wrapper pt-30">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title mb-30">
                            <h2>Update Products</h2>
                        </div>
                    </div>
                </div>

                <div class="card-style mb-30">
                    <h6 class="mb-25">Update Product Details</h6>
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>

                    <div class="input-style-1">
                        <label>Product ID</label>
                        <asp:TextBox ID="txtProductId" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    
                    <div class="input-style-1">
                        <label>Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>

                    <div class="input-style-1">
                        <label>Brand</label>
                        <asp:TextBox ID="txtBrand" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>

                    <div class="input-style-1">
                        <label>Price</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>

                    <div class="input-style-1">
                        <label>Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>

                   <!-- Image Uploads with Real-Time Preview -->
                    <div class="input-style-1">
                        <label>Image 1</label><br />
                        <img id="preview1" style="width:150px; display:none;" alt="New Preview Image" />
                        <asp:Image ID="imgPreview1" runat="server" Width="150px" Style="display:block;" />
                        <asp:FileUpload ID="fileUpload1" runat="server" onchange="previewImage(this, 'preview1', 'imgPreview1')" />
                    </div>

                    <div class="input-style-1">
                        <label>Image 2</label><br />
                        <img id="preview2" style="width:150px; display:none;" alt="New Preview Image" />
                        <asp:Image ID="imgPreview2" runat="server" Width="150px" Style="display:block;" />
                        <asp:FileUpload ID="fileUpload2" runat="server" onchange="previewImage(this, 'preview2', 'imgPreview2')" />
                    </div>

                    <div class="input-style-1">
                        <label>Image 3</label><br />
                        <img id="preview3" style="width:150px; display:none;" alt="New Preview Image" />
                        <asp:Image ID="imgPreview3" runat="server" Width="150px" Style="display:block;" />
                        <asp:FileUpload ID="fileUpload3" runat="server" onchange="previewImage(this, 'preview3', 'imgPreview3')" />
                    </div>


                    <asp:Button ID="btnUpdate" runat="server" CssClass="main-btn primary-btn btn-hover" Text="Update Product" OnClick="btnUpdate_Click" />
                </div>
            </div>
        </div>
    </section>

    <script>
   function previewImage(input, previewId, oldImageId) {
    var file = input.files[0];
    if (file) {
        var reader = new FileReader();
        reader.onload = function (e) {
            var preview = document.getElementById(previewId);
            var oldImage = document.getElementById(oldImageId);

            preview.src = e.target.result;
            preview.style.display = "block"; // Show new preview
            if (oldImage) {
                oldImage.style.display = "none"; // Hide old image completely
            }
        };
        reader.readAsDataURL(file);
    }
}


</script>
</asp:Content>
