<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="OrderAndShipping.aspx.cs" Inherits="UrbanKicks.OrderAndShipping" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>

        .main {
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 65vh;
            padding: 10px;
        }

        .order-shipping {
            max-width: 900px;
            background: white;
            padding: 40px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: row;
            align-items: flex-start;
            gap: 40px;
        }

        .order-title {
            font-size: 20px;
            font-weight: bold;
            flex: 1;
            text-align: center;
            color: #000;
        }

        .order-content {
            flex: 3;
        }

        .order-content p {
            font-size: 16px;
            line-height: 1.6;
            color: #333;
            margin-bottom: 15px;
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main">
         <section class="order-shipping">
        <div class="order-title">ORDER & SHIPPING POLICY 
            <img src="images/logo8-without-bg.png" alt="" height="50px">
        </div>
        <div class="order-content">
            <p>
                At <strong>UrbanKicks</strong>, we aim to ensure a smooth shopping experience for all our customers. 
                Below are our policies regarding order processing, shipping, and delivery.
            </p>

            <p>
                <strong>1. Order Processing</strong><br>
                Orders are processed within <strong>24-48 hours</strong> on business days (Monday to Friday). 
                Orders placed on weekends or public holidays will be processed on the next business day.
            </p>

            <p>
                <strong>2. Shipping Methods & Delivery Time</strong><br>
                We offer the following shipping options:<br>
                - **Standard Shipping:** 5-7 business days<br>
                - **Express Shipping:** 2-3 business days<br>
                - **International Shipping:** 7-14 business days (varies by destination)
            </p>

            <p>
                <strong>3. Tracking Your Order</strong><br>
                Once your order is shipped, you will receive an email with a tracking number. 
                You can track your order in the **"My Orders"** section on our website.
            </p>

            <p>
                <strong>4. Shipping Charges</strong><br>
                - Orders above ₹5,000 qualify for **FREE shipping** within India.<br>
                - Orders below ₹5,000 will have a flat ₹100 shipping charge.<br>
                - International shipping charges vary based on location and will be displayed at checkout.
            </p>

            <p>
                <strong>5. Order Delays</strong><br>
                We strive to deliver all orders on time, but occasional delays may occur due to **high demand, customs clearance, or unforeseen circumstances**. 
                We appreciate your patience in such cases.
            </p>

            <p>
                <strong>6. Returns & Refunds</strong><br>
                We accept returns within **7 days of delivery**, provided the items are unused and in original packaging. 
                Refunds will be processed within **7-10 business days** after inspection.
                For details, visit our <a href="ReturnPolicy.aspx">Return Policy</a> page.
            </p>

            <p>
                <strong>7. Contact Us</strong><br>
                If you have any shipping-related queries, feel free to contact our support team at 
                <strong>support@urbankicks.com</strong>.
            </p>

        </div>
    </section>
    </div>

</asp:Content>
