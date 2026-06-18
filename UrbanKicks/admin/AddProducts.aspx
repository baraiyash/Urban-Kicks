    <%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="AddProducts.aspx.cs" Inherits="UrbanKicks.admin.AddProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- ========== tab components start ========== -->
    <section class="tab-components">
        <div class="container-fluid">
            <!-- ========== title-wrapper start ========== -->
            <div class="title-wrapper pt-30">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title mb-30">
                            <h2>Add New Products</h2>
                        </div>
                    </div>
                    <!-- end col -->
                    <div class="col-md-6">
                        <div class="breadcrumb-wrapper mb-30">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="Dashboard.aspx">Dashboard</asp:HyperLink>
                                    </li>
                                    <li class="breadcrumb-item"><a>Products</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Create Products</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ========== title-wrapper end ========== -->

            <div class="form-elements-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <!-- input style start -->
                        <div class="card-style mb-30">
                            <h6 class="mb-25">Input Fields</h6>

                            <asp:Panel ID="pnlForm" runat="server">
                           <%--     <div class="input-style-1">
                                    <label>Product Id</label>
                                    <asp:TextBox ID="txtProductId" runat="server" CssClass="form-control" Placeholder="Product Id" required></asp:TextBox>
                                </div>--%>

                                <div class="input-style-1">
                                    <label>Name</label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Placeholder="Enter Name" required></asp:TextBox>
                                </div>

                                <div class="input-style-1">
                                    <label>Brand</label>
                                    <asp:TextBox ID="txtBrand" runat="server" CssClass="form-control" Placeholder="Enter Brand" required></asp:TextBox>
                                </div>

                                <div class="input-style-1">
                                    <label>Description</label>
                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" Placeholder="Enter Description" required></asp:TextBox>
                                </div>

                                <div class="input-style-1">
                                    <label>Price</label>
                                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number" Placeholder="Enter Price" required></asp:TextBox>
                                </div>
<!-- Image Upload Fields with Preview -->
                                <div class="input-style-1">
                                    <label>Image 1</label>
                                    <img id="preview1" src="#" alt="Image Preview" style="display:none; max-width: 150px; height: auto;" />
                                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" onchange="previewImage(this, 'preview1')" required />
                                </div>

                                <div class="input-style-1">
                                    <label>Image 2</label>
                                    <img id="preview2" src="#" alt="Image Preview" style="display:none; max-width: 150px; height: auto;" />
                                    <asp:FileUpload ID="FileUpload2" runat="server" CssClass="form-control" onchange="previewImage(this, 'preview2')" required />
                                </div>

                                <div class="input-style-1">
                                    <label>Image 3</label>
                                    <img id="preview3" src="#" alt="Image Preview" style="display:none; max-width: 150px; height: auto;" />
                                    <asp:FileUpload ID="FileUpload3" runat="server" CssClass="form-control" onchange="previewImage(this, 'preview3')" required />
                                </div>

                                <asp:Button ID="btnSubmit" runat="server" CssClass="main-btn primary-btn btn-hover" Text="Add Product" OnClick="btnSubmit_Click" />
                                
                            </asp:Panel>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
      <script>
        function previewImage(input, previewId) {
            var file = input.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var preview = document.getElementById(previewId);
                    preview.src = e.target.result;
                    preview.style.display = "block";
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</asp:Content>
