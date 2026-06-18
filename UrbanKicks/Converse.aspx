<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Converse.aspx.cs" Inherits="UrbanKicks.Converse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>Converse Products - Urban Kicks</title>
   <style>
        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 40px;
            padding: 40px;
            justify-content: center;
        }

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

       .nike-heading {
            position: absolute; /* Absolute position inside .sort-filter */
            left: 50%; /* Move to center */
            transform: translateX(-50%); /* Shift back by 50% of its width to truly center */
            font-size: 20px;
            font-weight: bold;
            color: #333;
            margin: 0;
        }

        .product {
            text-align: center;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .product img {
            width: 300px;
            height: 300px;
            object-fit: cover;
            display: block;
            margin-bottom: 10px;
            transition: opacity 0.3s ease-in-out;
        }

        .product .image-container {
            position: relative;
            width: 100%;
            height: 320px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .product .hover-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 300px;
            height: 300px;
            object-fit: cover;
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
        }

        .product:hover .hover-image {
            opacity: 1;
        }
    </style>
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
             <h2 class="nike-heading">Converse Products</h2>
    </div>

        <!-- Product Grid -->
        <div class="product-grid" id="productGrid">
            <asp:Repeater ID="ConverseProductList" runat="server">
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
