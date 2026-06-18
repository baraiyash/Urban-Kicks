<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="ManageProducts.aspx.cs" Inherits="UrbanKicks.admin.ManageProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .image-preview {
    position: absolute;
    display: none;
    border: 1px solid #ddd;
    background: white;
    padding: 5px;
    z-index: 1000;
    width: 200px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
}

    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="tab-components">
        <div class="container-fluid">
            <div class="title-wrapper pt-30">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title mb-30">
                            <h2>Manage Products</h2>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="breadcrumb-wrapper mb-30">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="Dashboard.aspx">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item"><a>Products</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">
                                        Manage Products
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tables-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card-style mb-30">
                            <h6 class="mb-10">Product List</h6>
                            <div class="table-wrapper table-responsive">
                                <asp:GridView ID="GridViewFlights" runat="server" AutoGenerateColumns="False" CssClass="table" GridLines="None" BorderStyle="None">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Product ID" />
                                        <asp:BoundField DataField="Name" HeaderText="Product Name" />
                                        <asp:BoundField DataField="Brand" HeaderText="Product Brand" />
                                        <asp:BoundField DataField="Description" HeaderText="Description" />

                                        <asp:TemplateField HeaderText="Images">
                                            <ItemTemplate>
                                                <span class="image-hover" data-image='<%# "../images/" + Eval("ImageUrl") %>'>Image 1</span>
                                                <span class="image-hover" data-image='<%# "../images/" + Eval("ImageUrl2") %>'>Image 2</span>
                                                <span class="image-hover" data-image='<%# "../images/" + Eval("ImageUrl3") %>'>Image 3</span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-primary" Text="Update" 
                                                    PostBackUrl='<%# Eval("ID", "UpdateProducts.aspx?id={0}") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger" Text="Delete" 
                                                    CommandArgument='<%# Eval("ID") %>' OnClick="DeleteFlight_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div id="image-preview" class="image-preview">
        <img id="preview-img" src="" alt="Preview" style="width: 100%;">
    </div>

    <script>
       document.addEventListener("DOMContentLoaded", function () {
    console.log("DOM fully loaded. Binding events...");
    
    let preview = document.getElementById("image-preview");
    let previewImg = document.getElementById("preview-img");

    document.querySelectorAll(".image-hover").forEach(item => {
        item.addEventListener("mouseover", function (event) {
            let imageUrl = this.getAttribute("data-image");
            
            if (imageUrl && imageUrl.trim() !== "") {
                previewImg.src = imageUrl;
                preview.style.display = "block";

                // Display image to the LEFT of the cursor
                let offsetX = -170; // Adjust as needed
                preview.style.top = event.pageY + "px";
                preview.style.left = (event.pageX + offsetX) + "px";
            } else {
                console.log("Image URL is empty or invalid for: " + this.innerText);
            }
        });

        item.addEventListener("mousemove", function (event) {
            let offsetX = -170; // Adjust as needed
            preview.style.top = event.pageY + "px";
            preview.style.left = (event.pageX + offsetX) + "px";
        });

        item.addEventListener("mouseout", function () {
            preview.style.display = "none";
        });
    });
});

    </script>
</asp:Content>
