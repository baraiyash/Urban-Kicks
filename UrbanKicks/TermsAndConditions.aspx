<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="TermsAndConditions.aspx.cs" Inherits="UrbanKicks.TermsAndConditions" %>
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

        .terms {
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

        .terms-title {
            font-size: 20px;
            font-weight: bold;
            flex: 1;
            text-align: center;
            color: #000;
        }

        .terms-content {
            flex: 3;
        }

        .terms-content p {
            font-size: 16px;
            line-height: 1.6;
            color: #333;
            margin-bottom: 15px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main">
         <section class="terms">
        <div class="terms-title">TERMS & CONDITIONS
            <img src="images/logo8-without-bg.png" alt="" height="50px">
        </div>
        <div class="terms-content">
            <p>
                Welcome to <strong>UrbanKicks</strong>. By accessing or using our website, you agree to comply with the following **Terms & Conditions**. 
                Please read them carefully before making any purchase.
            </p>

            <p>
                <strong>1. User Agreement</strong><br>
                By using our website, you confirm that you are at least 18 years old or have parental consent to use this platform.
            </p>

            <p>
                <strong>2. Product Information & Availability</strong><br>
                We strive to ensure that all product descriptions and images are accurate. However, minor variations in color, design, and appearance may occur. 
                Availability of products is subject to change without prior notice.
            </p>

            <p>
                <strong>3. Pricing & Payment</strong><br>
                All prices are displayed in **Indian Rupees (INR)** and are inclusive of applicable taxes.  
                We accept payments through **credit/debit cards, net banking, and digital wallets**.  
                UrbanKicks reserves the right to update pricing at any time.
            </p>

            <p>
                <strong>4. Order Cancellation & Refunds</strong><br>
                - Orders can be canceled before they are shipped.<br>
                - Refunds will be processed within **7-10 business days** for eligible cancellations.<br>
                - For return and refund policies, please visit our <a href="ReturnPolicy.aspx">Return Policy</a> page.
            </p>

            <p>
                <strong>5. User Conduct & Restrictions</strong><br>
                Users are prohibited from:<br>
                - Using this site for any fraudulent or illegal activities.<br>
                - Attempting to access restricted areas of the website without authorization.<br>
                - Copying, reproducing, or distributing content without prior consent.
            </p>

            <p>
                <strong>6. Intellectual Property Rights</strong><br>
                All content on this website, including text, images, logos, and designs, is the property of **UrbanKicks**. 
                Unauthorized use of any material is strictly prohibited.
            </p>

            <p>
                <strong>7. Limitation of Liability</strong><br>
                UrbanKicks shall not be liable for any direct, indirect, incidental, or consequential damages arising from the use of our website or products.
            </p>

            <p>
                <strong>8. Changes to Terms & Conditions</strong><br>
                UrbanKicks reserves the right to modify these terms at any time. 
                Changes will be updated on this page, and continued use of our website constitutes acceptance of the revised terms.
            </p>

            <p>
                <strong>9. Contact Us</strong><br>
                If you have any questions about these terms, please contact us at <strong>support@urbankicks.com</strong>.
            </p>

        </div>
    </section>
    </div>
</asp:Content>
