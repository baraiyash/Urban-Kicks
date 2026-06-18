<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="PrivacyPolicy.aspx.cs" Inherits="UrbanKicks.PrivacyPolicy" %>
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

    .privacy-policy {
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

    .privacy-title {
        font-size: 20px;
        font-weight: bold;
        flex: 1;
        text-align: center;
        color: #000;
    }

    .privacy-content {
        flex: 3;
    }

    .privacy-content p {
        font-size: 16px;
        line-height: 1.6;
        color: #333;
        margin-bottom: 15px;
    }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="main">
         <section class="privacy-policy">
        <div class="privacy-title">PRIVACY POLICY <br>
            <img src="images/logo8-without-bg.png" alt="" height="50px">
        </div>
        <div class="privacy-content">
            <p>
                At <strong>UrbanKicks</strong>, we are committed to protecting your privacy. 
                This Privacy Policy explains how we collect, use, and safeguard your personal information 
                when you visit our website.
            </p>
            
            <p>
                <strong>1. Information We Collect</strong><br>
                We collect personal information such as your name, email address, phone number, and billing/shipping details 
                when you create an account, place an order, or subscribe to our newsletter.
            </p>
            
            <p>
                <strong>2. How We Use Your Information</strong><br>
                We use your personal information to process your orders, provide customer support, and improve our services. 
                We may also use your information to send promotional emails or updates about our latest collections.
            </p>

            <p>
                <strong>3. Data Security</strong><br>
                We implement industry-standard security measures to protect your data. Your payment information is encrypted 
                and processed securely through trusted payment gateways.
            </p>

            <p>
                <strong>4. Third-Party Sharing</strong><br>
                We do not sell or share your personal information with third parties except for trusted partners who assist in 
                operating our website and conducting business (e.g., shipping providers, payment processors).
            </p>

            <p>
                <strong>5. Cookies and Tracking</strong><br>
                We use cookies to enhance your browsing experience and analyze website traffic. You can disable cookies in your browser 
                settings, but some features may not function properly.
            </p>

            <p>
                <strong>6. Your Rights</strong><br>
                You have the right to access, modify, or delete your personal data. If you have any concerns about your privacy, 
                please contact us at <strong>support@urbankicks.com</strong>.
            </p>

            <p>
                <strong>7. Changes to this Policy</strong><br>
                We may update this Privacy Policy from time to time. Any changes will be posted on this page, and we encourage you 
                to review it periodically.
            </p>
        </div>
    </section>
    </div>
</asp:Content>
