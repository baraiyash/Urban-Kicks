<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="UrbanKicks.SignIn" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .container {
            width: 800px;
            background: white;
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            left: 50%;
            transform: translateX(-50%);
            margin-top: 50px;
            margin-bottom: 50px;
            text-align: center;
        }
        h2 {
            font-size: 32px;
            text-align: center;
            margin-bottom: 70px;
            margin-top: -30px;
        }
        .form-group {
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
        }
        .checkout-btn {
            background-color: grey !important;
            color: white !important;
            border: none;
            padding: 15px 40px !important;
            font-size: 18px !important;
            font-weight: bold !important;
            text-transform: uppercase;
            cursor: pointer;
            margin: 30px;
            border-radius: 8px;
            transition: background-color 0.3s ease-in-out, transform 0.2s;
        }
        .form-group input {
            width: 600px;
            height: 30px;
            font-size: 18px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-align: center;
        }
        .button {
            text-align: center;
            margin-top: 20px;
        }
        .checkout-btn:hover {
            background-color: black !important;
            transform: scale(1.05);
        }
        .checkout {
            text-align: center;
            margin-top: 20px;
        }
        .error-popup {
            position: absolute;
            left: 50%;
            top: 90%; /* Adjust if needed */
            transform: translate(-50%, -50%); /* Center both horizontally & vertically */
    
            display: block;
            background: rgba(255, 0, 0, 0.9);
            color: white;
            padding: 10px;
            border-radius: 5px;
            text-align: center;
            font-size: 16px;
            opacity: 0; /* Start hidden */
            visibility: hidden; /* Hide it initially */
            transition: opacity 0.3s ease-in-out, visibility 0.3s ease-in-out;
        }

        .error-popup.show {
            opacity: 1; 
            visibility: visible;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <asp:Panel ID="pnlSignIn" runat="server">
            <h2>SIGN IN</h2>
            <div class="form-group">
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
            </div>
            <div class="form-group">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
            </div>
            <div class="button">
                <asp:Button ID="btnSubmit" runat="server" CssClass="checkout-btn" Text="Sign In" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnRegister" runat="server" Text="REGISTER" CssClass="checkout-btn" OnClick="btnRegister_Click"/>
               <asp:Label ID="lblError" runat="server" CssClass="error-popup text-danger" Visible="false"></asp:Label>
            </div>
        </asp:Panel>

        <!-- USER PROFILE PANEL -->
        <asp:Panel ID="pnlUserProfile" runat="server" Visible="false">
            <h2>Welcome, <asp:Label ID="lblUsername" runat="server"></asp:Label>!</h2>
            <p><strong>First Name:</strong> <asp:Label ID="lblFirstName" runat="server"></asp:Label></p>
            <p><strong>Last Name:</strong> <asp:Label ID="lblLastName" runat="server"></asp:Label></p>
            <p><strong>Phone:</strong> <asp:Label ID="lblPhone" runat="server"></asp:Label></p>
            <p><strong>Date of Birth:</strong> <asp:Label ID="lblDOB" runat="server"></asp:Label></p>
            <p><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server"></asp:Label></p>
            <asp:Button ID="btnLogout" runat="server" CssClass="checkout-btn" Text="Logout" OnClick="btnLogout_Click" />

        </asp:Panel>

    </div>
</asp:Content>
