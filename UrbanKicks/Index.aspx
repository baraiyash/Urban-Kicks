<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="UrbanKicks.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Urban Kicks</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>

        .sort-filter {
            position: relative; /* Needed for absolute positioning inside */
            display: flex;
            align-items: center;
            justify-content: flex-start;
            background: #f9f9f9;
            padding: 12px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        
        .sort-options {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .sort-filter label {
            font-weight: bold;
            font-size: 14px;
            color: #333;
        }

        .sort-filter select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease-in-out;
            background: #fff;
            cursor: pointer;
        }

        .sort-filter select:hover {
            border-color: #555;
        }


        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 4 equal columns */
            gap: 40px;
            padding: 40px;
            justify-content: center;
        }

        .product {
            text-align: center;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .product img {
            width: 300px; /* Adjust to fit container */
            height: 300px; /* Set a uniform height */
            object-fit: cover; /* Crop to fit without stretching */
            display: block;
            margin-bottom: 10px;
            transition: opacity 0.3s ease-in-out;
        }
       .product .image-container {
            position: relative;
            width: 100%;
            height: 320px; /* Uniform height */
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        /* Default image for new products (1360×1600) */
        .product .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* Ensures proper scaling without zooming out */
            display: block;
            transition: opacity 0.3s ease-in-out;
        }

        /* Hover effect - Smooth image swap */
        .product .hover-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 300px;
            height: 300px;
            object-fit: cover; /* Prevents zooming issues */
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }

        .product:hover .hover-image {
            opacity: 1;
        }
       .product h3, .product p {
            margin: 6px 0;
            padding: 0;
            line-height: 1.8;
        }

        .brand, .name, .price {
            margin: 1px;
        }
      
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
       <div class="sort-filter">
        <div class="sort-options">
            <label for="sort">Sort by:</label>
            <select id="sort" onchange="sortProducts()">
                <option value="default">Default</option>
                <option value="low-high">Price: Low to High</option>
                <option value="high-low">Price: High to Low</option>
            </select>
        </div>
    </div>

        <div class="product-grid" id="productGrid">
            <asp:Repeater ID="ProductList" runat="server">
                <ItemTemplate>
                    <div class="product" data-price='<%# Eval("Price") %>'>
                        <a href='Product.aspx?Id=<%# Eval("Id") %>'>
                            <img src='<%# "images/" + Eval("ImageUrl") %>' alt='<%# Eval("Name") %>' />
                            <img class="hover-image" src="images/<%# Eval("ImageUrl2") %>" alt='<%# Eval("Name") %> Hover' />
                        </a>
                        <h3>
                            <a href='Product.aspx?Id=<%# Eval("Id") %>' style="text-decoration: none; color: black;">
                                <%# Eval("Name") %>
                            </a>
                        </h3>
                        <p>
                            <a href='Product.aspx?Id=<%# Eval("Id") %>' style="text-decoration: none; color: black;">
                                <b>Price: ₹<%# Eval("Price") %></b>
                            </a>
                        </p>
                        <!-- Clickable Brand -->
                        <p>
                            <a href='Product.aspx?Id=<%# Eval("Id") %>' style="text-decoration: none; color: black;">
                              <b>  <%# Eval("Brand") %> </b>
                            </a>
                        </p>

                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- JavaScript for Sorting -->
        <script>
            function sortProducts() {
                let sortBy = document.getElementById("sort").value;
                let productGrid = document.getElementById("productGrid");

                if (!productGrid) {
                    console.error("Error: productGrid not found");
                    return;
                }

                let products = Array.from(productGrid.getElementsByClassName("product"));

                products.forEach(product => {
                    product.dataset.price = product.getAttribute("data-price"); // Ensure dataset is populated
                });

                if (sortBy === "low-high") {
                    products.sort((a, b) => parseInt(a.dataset.price) - parseInt(b.dataset.price));
                } else if (sortBy === "high-low") {
                    products.sort((a, b) => parseInt(b.dataset.price) - parseInt(a.dataset.price));
                }

                products.forEach(product => productGrid.appendChild(product));
            }
        </script>
    </main>
</asp:Content>
