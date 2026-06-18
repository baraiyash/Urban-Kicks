<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="UrbanKicks.Cart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Shopping Cart</title>
        <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0px;
        }

        .cart-container {
            max-width: 1100px;
            margin: 40px auto 40px auto;
            background-color: white;
            padding: 20px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            display: block;
            text-align: center;
            padding-top: 70px;
        }

        h2 {
            font-size: 20px;
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            font-size: 14px;
            font-weight: bold;
            border-bottom: 2px solid #ccc;
        }

        .product-image img {
            width: 300px;
        }

        .product-description {
            font-size: 20px;
            word-wrap: break-word;
            width: 600px;
            white-space: normal;
        }

        .product-name {
            font-weight: bold;
            width: 600px;
        }

        .product-color {
            font-size: 12px;
            color: gray;
        }

        .size-selector {
            display: flex;
            align-items: center;
            margin-top: 15px;
        }

        .size-selector label {
            margin-right: 10px;
            font-weight: bold;
        }

        .size-selector select {
            padding: 5px;
            border: 1px solid #ccc;
        }

        .remove {
            color: red;
            margin-left: 20px;
            cursor: pointer;
            font-weight: bold;
            font-size: 18px;
        }

        .summary {
            margin-top: 20px;
            background-color: #f9f9f9;
            padding: 10px;
        }

        .summary table {
            width: 135%;
        }

        .grand-total {
            font-size: 20px;
        }

        .discount {
            display: flex;
            margin-top: 20px;
        }

        .discount input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
        }

        .discount button {
            background-color: black;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }

        .checkout {
            text-align: center;
            margin-top: 20px;
            
        }

        .checkout button {
            background-color: black;
            color: white;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            cursor: pointer;
        }

        .empty-cart {
            text-align: center;
            font-size: 22px;
            font-weight: bold;
            padding: 50px;
        }
        .checkout-btn {
            background-color: grey !important; /* Change button background color (Orange) */
            color: white !important; /* Keep text white */
            border: none;
            padding: 15px 40px !important; /* Increase padding for bigger size */
            font-size: 18px !important; /* Increase font size */
            font-weight: bold !important;
            text-transform: uppercase; /* Makes text uppercase */
            cursor: pointer;
            margin:30px;
            border-radius: 8px; /* Optional: Adds rounded corners */
            transition: background-color 0.3s ease-in-out, transform 0.2s;
        }

        /* Add hover effect */
        .checkout-btn:hover {
            background-color: black !important; /* Darker orange on hover */
            transform: scale(1.05); /* Slightly increase size on hover */
        }

        .empty-cart-message {
            text-align: center;
            font-size: 32px; /* Increase text size */
            font-weight: bold;
            padding: 100px 0; /* Add top and bottom padding */
            color: #333; /* Adjust text color */
        }


        .auto-style1 {
                width: 59px;
         }


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="cartPanel" runat="server">
        <h2 style="padding-left:530px;font-size:60px">SHOPPING CART</h2>
        <div class="cart-container">

            <!-- Table for Cart Items -->
            <table>
                <thead>
                    <tr>
                        <th style="font-size: 20px">PRODUCT</th>
                        <th style="font-size: 20px">DESCRIPTION</th>
                        <th style="font-size: 20px">PRICE</th>
                        <th style="font-size: 20px">QTY</th>
                        <th style="font-size: 20px">REMOVE</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptCart" runat="server" OnItemDataBound="rptCart_ItemDataBound">
                        <ItemTemplate>
                            <tr>
                                <!-- Product Image -->
                                <td class="product-image" style="text-align: center;">
                                    <img src='<%# Eval("ImageUrl") %>' width="100px" />
                                    <br />
                                    <div class="size-selector">
                                        <label>SIZE :</label>
                                        <asp:Label ID="lblSize" runat="server" Text='<%# Eval("Size") %>'></asp:Label>
                                    </div>
                                </td>

                                <!-- Product Description -->
                                <td class="product-description">
                                    <strong class="brand-name"><%# Eval("Brand") %></strong><br /><br />
                                    <span class="product-name">
                                        <%# Eval("ProductName") %>
                                    </span><br />
                                </td>

                                <!-- Price -->
                                <td style="font-size: 20px">₹<%# Eval("Price", "{0:N2}") %></td>

                                <!-- Quantity Dropdown -->
                                <td>
                                    <asp:DropDownList ID="ddlQuantity" runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlQuantity_SelectedIndexChanged"
                                        Style="font-size: 16px; border: black 2px solid;">
                                        <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    </asp:DropDownList>
                                </td>

                                <!-- Remove Button -->
                                <td>
                                    <asp:Button ID="btnRemove" runat="server" Text="X" CssClass="remove-btn" OnClick="btnRemove_Click" />
                                </td>

                                <!-- Hidden Field for ProductId -->
                                <asp:HiddenField ID="hdnProductId" runat="server" Value='<%# Eval("ProductId") %>' />
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>

            <!-- Summary Section -->
            <div class="summary">
                <table>
                    <tr class="grand-total">
                        <td><strong>GRAND TOTAL</strong></td>
                        <td><strong><asp:Label ID="lblGrandTotal" runat="server"></asp:Label></strong></td>
                    </tr>
                </table>
            </div>

            <!-- Checkout Buttons -->
            <div class="checkout">
                <asp:Button ID="btnCheckout" runat="server" Text="CHECKOUT" CssClass="checkout-btn" OnClick="btnCheckout_Click" />
            </div>
        </div>
    </asp:Panel>

    <!-- Empty Cart Message -->
    <asp:Literal ID="litCartMessage" runat="server"></asp:Literal>
</asp:Content>
