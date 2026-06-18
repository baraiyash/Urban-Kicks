<%--<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="UrbanKicks.Checkout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/footerstyles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Order Receipt</title>
    <style>
        .main-ticket {
            background-color: #aeeeee;
            font-family: 'Roboto', sans-serif;
            padding: 20px;
        }
        .booking-ticket {
            background-color: #ffffff;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 30px;
            max-width: 800px;
            margin: 3% auto;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .booking-ticket h1 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .booking-ticket p {
            font-size: 18px;
            line-height: 1.8;
            margin-bottom: 15px;
        }
        .btn-print-ticket {
            display: block;
            margin: 30px auto 0;
            padding: 12px 25px;
            background-color: #00796b;
            color: #ffffff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
        }
        .btn-print-ticket:hover {
            background-color: #005f56;
        }
        @media print {
            body * {
                visibility: hidden;
            }
            .booking-ticket, .booking-ticket * {
                visibility: visible;
            }
            .booking-ticket {
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                margin: 0;
                padding: 20px;
                border: none;
                box-shadow: none;
            }
        }
        hr {
    border: 2px solid black; /* Makes the line thicker and darker */
    margin: 15px 0; /* Adds spacing */
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="booking-ticket">
        <h1>Your Purchase Receipt</h1> <!-- Header appears only once -->
        
        <asp:Literal ID="litProductDetails" runat="server"></asp:Literal> <!-- Multiple products here -->

        <hr> <!-- Separator before total amount -->

        <asp:Literal ID="litTotalAmount" runat="server"></asp:Literal> <!-- Final amount displayed here -->

         <label for="ddlPaymentMethod"><strong>Select Payment Method:</strong></label>
       <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="payment-dropdown"
            AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged">
            <asp:ListItem Text="Select Payment Method" Value="" />
            <asp:ListItem Text="Net Banking" Value="Net Banking" />
            <asp:ListItem Text="Cash on Delivery" Value="Cash on Delivery" />
            <asp:ListItem Text="Debit/Credit Card" Value="Debit/Credit Card" />
            <asp:ListItem Text="UPI" Value="UPI" />
       </asp:DropDownList>


        <a href="javascript:window.print()" class="btn-print-ticket">Print Receipt</a>
    </div>
</asp:Content>

--%>




<%@ Page Title="Order Receipt" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="UrbanKicks.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Order Receipt - Urban Kicks</title>
     <style>
        body {
            font-family: 'Roboto', sans-serif;
            font-size: 18px; /* Increased font size */
        }

        .main-ticket {
            background-color: #aeeeee;
            padding: 20px;
        }

        .booking-ticket {
            background-color: #ffffff;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 40px;
            max-width: 900px; /* Increased width */
            margin: 3% auto;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            font-size: 20px; /* Increased font size */
        }

        .booking-ticket h1 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 28px; /* Bigger heading */
            font-weight: bold;
        }

        .booking-ticket p {
            font-size: 20px; /* Increased font size */
            line-height: 2;
            margin-bottom: 20px;
        }

        .payment-dropdown {
            padding: 12px;
            font-size: 18px; /* Bigger font size */
            width: 100%;
            border: 2px solid #ccc;
            border-radius: 6px;
            margin-top: 15px;
            cursor: pointer;
        }

        .btn-print-ticket {
            display: block;
            margin: 40px auto 0;
            padding: 15px 30px; /* Increased button size */
            background-color: grey !important;
            color : white !important;
            border: none;
            border-radius: 8px;
            font-size: 23px !important;
            font-weight : bold !important;
            text-transform: uppercase;
            cursor: pointer;
            text-align: center;
           
            width: 230px;
            max-width: 300px; /* Prevent button from being too wide */
            height: 60px; /* Increased button height */
            font-weight: bold;
        }

        .btn-print-ticket:hover {
            background-color: black !important; /* Darker orange on hover */
            transform: scale(1.05); /* Slightly increase size on hover */
        }

        .product-details {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            align-items: center;
            text-align: center;
            gap: 30px; /* Increased spacing */
            margin-bottom: 20px; /* More spacing */
        }

        .product-details strong {
            font-size: 22px;
        }

        hr {
            border: 3px solid black; /* Single thick line */
            margin: 20px 0; /* Extra spacing */
        }
       @media print {
    body * {
        visibility: hidden;
    }
    .booking-ticket, .booking-ticket * {
        visibility: visible;
    }
    .booking-ticket {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        margin: 0;
        padding: 20px;
        border: none;
        box-shadow: none;
    }
    .btn-print-ticket {
        display: none !important;
    }
}


    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="checkout-container">
        <div class="booking-ticket">
            <h1>Your Purchase Receipt</h1>
            
            <asp:Literal ID="litProductDetails" runat="server"></asp:Literal>
            
            <hr>
            
            <asp:Literal ID="litTotalAmount" runat="server"></asp:Literal>
            
            <label for="ddlPaymentMethod"><strong>Select Payment Method:</strong></label>
            <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="payment-dropdown"
                AutoPostBack="true" OnSelectedIndexChanged="ddlPaymentMethod_SelectedIndexChanged">
                <asp:ListItem Text="Select Payment Method" Value="" />
                <asp:ListItem Text="Net Banking" Value="Net Banking" />
                <asp:ListItem Text="Cash on Delivery" Value="Cash on Delivery" />
                <asp:ListItem Text="Debit/Credit Card" Value="Debit/Credit Card" />
                <asp:ListItem Text="UPI" Value="UPI" />
            </asp:DropDownList>
            


            <asp:Button ID="btnPrint" runat="server" Text="Print Receipt" CssClass="btn-print-ticket" OnClick="btnPrint_Click" />

        </div>
    </div>
</asp:Content>



