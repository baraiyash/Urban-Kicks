<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="UrbanKicks.Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>PRODUCT PAGE</title>
    <link rel="stylesheet" href="styles.css" />
   <style>
        body { 
            font-family: Arial, sans-serif; 
            background-color: #f8f8f8; 
            margin: 0; 
            padding: 0; 
        }

        .product-container { 
            display: flex;
            max-width: 1200px;
            margin: 50px auto;
            background: white; 
            padding: 30px; 
            border-radius: 10px; 
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); 
        }

        .image-section {
            display: flex;
            flex-direction: column; /* Stack image and dots vertically */
            align-items: center; /* Center align */
        }

        /* ✅ Updated Image Styling */
        .product-image {
            width: 100%;/* Ensure responsiveness */
            max-width: 800px; /* Limit width */
            height: 600px; /* Fixed height for consistency */
            object-fit: contain; /* Ensures image is not cropped */
            border-radius: 10px;
            width: 600px;
        }

        .details-section { 
            margin-left: 50px; 
            max-width: 500px; 
            font-size: 20px; 
        }

        h1 { 
            font-size: 22px; 
            margin-bottom: 10px; 
        }

        .price { 
            font-size: 20px; 
            font-weight: bold; 
            color: #333; 
        }

        .tax-info { 
            font-size: 14px; 
            color: gray; 
        }

        .description { 
            margin: 15px 0; 
            font-size: 18px; 
            color: #555; 
        }

        /* Size Selection Styling */
        .size-selection {
            display: flex;
            flex-direction: row;
            margin-bottom: 20px;
            margin-top: 70px;
            margin-left: 100px;
        }

        .size-label {
            font-size: 23px;
            font-weight: bold;
            margin-top: 80px;
        }

        .size-dropdown {
            padding: 8px;
            font-size: 16px;
            width: 100px;
            margin: 0px 20px;
            height: 50px;
            margin-top: 60px;
        }

        #sizeError {
            color: red;
            display: none;
            font-size: 14px;
            margin-top: 5px;
        }

        /* Add to Cart Button */
        .add-to-bag { 
            background: black; 
            color: white; 
            font-weight: bold; 
            width: 300px; 
            height: 50px; 
            font-size: 25px; 
            cursor: pointer; 
            border: none; 
            margin-top: 20px; 
            margin-left: 100px;
        }

        .add-to-bag:hover {
            background-color: #333;
        }

        /* Image Dots for Multiple Images */
        .image-dots {
            margin-top: 10px;
            text-align: center;
        }

        .dot {
            height: 15px;
            width: 15px;
            margin: 5px;
            background-color: gray;
            border-radius: 50%;
            display: inline-block;
            cursor: pointer;
        }

        .dot.active { 
            background-color: black; 
        }

        /* Checkout Button */
        .checkout-btn {
            background-color: grey !important; 
            color: white !important; 
            border: none;
            padding: 18px 50px !important; 
            font-size: 20px !important; 
            font-weight: bold !important;
            text-transform: uppercase; 
            cursor: pointer;
            margin: 30px;
            border-radius: 8px; 
            transition: background-color 0.3s ease-in-out, transform 0.2s;
            margin-left: 100px;
        }

        .checkout-btn:hover {
            background-color: black !important;
            transform: scale(1.05);
        }
</style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="product-container">
                <div class="image-section">
                    <asp:Image ID="ImageProduct" runat="server" CssClass="product-image" />

                    <div class="image-dots">
                        <asp:Repeater ID="ImageRepeater" runat="server">
                            <ItemTemplate>
                                <span class="dot" onclick='<%# "changeImage(\"" + Eval("ImageUrl") + "\", this)" %>'></span>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
             </div>



       <div class="details-section">
    <p class="brand"><asp:Label ID="lblProductBrand" runat="server"></asp:Label></p>
    <h1><asp:Label ID="lblProductName" runat="server"></asp:Label></h1>
    <p class="price"><asp:Label ID="lblProductPrice" runat="server"></asp:Label></p>
    <p class="description"><asp:Label ID="lblProductDescription" runat="server"></asp:Label></p>

    <!-- Size Selection Section -->
    <div class="size-selection">
        <label class="size-label" for="ddlSize">Select Size:</label>
        <asp:DropDownList ID="ddlSize" runat="server" CssClass="size-dropdown" AutoPostBack="true">
            <asp:ListItem Value="3">UK 3</asp:ListItem>
            <asp:ListItem Value="4">UK 4</asp:ListItem>
            <asp:ListItem Value="5">UK 5</asp:ListItem>
            <asp:ListItem Value="6">UK 6</asp:ListItem>
            <asp:ListItem Value="7">UK 7</asp:ListItem>
            <asp:ListItem Value="8">UK 8</asp:ListItem>
            <asp:ListItem Value="9">UK 9</asp:ListItem>
            <asp:ListItem Value="10">UK 10</asp:ListItem>
        </asp:DropDownList>
        <span id="sizeError" style="color:red; display:none;">Please select a size</span>
    </div>

      <div class="checkout">  
        <asp:Button ID="btnCheckout" runat="server" Text="Add to Cart" CssClass="checkout-btn" OnClientClick="return validateSize();" OnClick="BtnAddToBag_Click" />
      </div>
</div>

    </div>

    <script>
         function changeImage(imageSrc, clickedDot) {
        document.getElementById("<%= ImageProduct.ClientID %>").src = imageSrc;

        let dots = document.querySelectorAll(".dot");
        dots.forEach(dot => dot.classList.remove("active"));
        clickedDot.classList.add("active");
    }

        function validateSize() {
            var ddlSize = document.getElementById("<%= ddlSize.ClientID %>");
            var errorSpan = document.getElementById("sizeError");

            if (ddlSize.value === "") {
                errorSpan.style.display = "block"; // Show error message
                return false; // Prevent button click
            } else {
                errorSpan.style.display = "none"; // Hide error message
                return true; // Allow button click
            }
        }
    </script>
</asp:Content>
