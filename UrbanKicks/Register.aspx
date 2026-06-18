<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="UrbanKicks.Register" %>
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

.form-group, .input-group {
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    width: 100%;
}

.form-group input, .input-group input {
    width: 300px;
    height: 30px;
    font-size: 18px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    text-align: center;
}

.form-row {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    margin-bottom: 20px;
}

.input-group {
    width: 290px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
}

.error {
    color: red;
    font-size: 14px;
    margin-top: 5px;
    text-align: center;
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
    margin: 20px;
    border-radius: 8px;
    transition: background-color 0.3s ease-in-out, transform 0.2s;
}

.checkout-btn:hover {
    background-color: black !important;
    transform: scale(1.05);
}

.button {
    text-align: center;
}
#txtMobile:focus {
    background-color: white; /* Keeps the background color consistent */
    outline: none; 
    box-shadow: none; 
    border: 1px solid #ccc;
}



    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h2>CREATE ACCOUNT</h2>

        <div class="form-row">
            <div class="input-group">
                <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="First Name"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regexFirstName" runat="server"
                    ControlToValidate="txtFirstName"
                    ErrorMessage="First name should numbers"
                    ValidationExpression="^[A-Za-z]+$"
                    CssClass="error"></asp:RegularExpressionValidator>
            </div>

            <div class="input-group">
                <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder="Last Name"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regexLastName" runat="server"
                    ControlToValidate="txtLastName"
                    ErrorMessage="Last name cannot contain numbers."
                    ValidationExpression="^[A-Za-z]+$"
                    CssClass="error"></asp:RegularExpressionValidator>
            </div>
        </div>

        <div class="form-group">
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Email Address"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqEmail" runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email is required."
                CssClass="error"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regexEmail" runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Enter a valid email address."
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                CssClass="error"></asp:RegularExpressionValidator>
        </div>

        <div class="form-row">
            <div class="input-group">
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Mobile"></asp:TextBox>
                <asp:RegularExpressionValidator ID="regexMobile" runat="server"
                    ControlToValidate="txtMobile"
                    ErrorMessage="Phone number must be exactly 10 digits."
                    ValidationExpression="^\d{10}$"
                    CssClass="error"></asp:RegularExpressionValidator>
            </div>
            <div class="input-group">
                <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
            <%--<asp:RegularExpressionValidator ID="regexUsername" runat="server"
                ControlToValidate="txtUsername"
                ErrorMessage="Username must be at least 5 characters long."
                ValidationExpression=".{5,}"
                CssClass="error"></asp:RegularExpressionValidator>--%>
        </div>

        <div class="form-group">
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
           <%-- <asp:RegularExpressionValidator ID="regexPassword" runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="Password must be at least 6 characters with one uppercase, one lowercase, one number, and one special character."
                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%?&])[A-Za-z\d@$!%?&]{6,}$"
                CssClass="error"></asp:RegularExpressionValidator>--%>
        </div>

        <div class="button">
            <asp:Button ID="btnRegister" runat="server" CssClass="checkout-btn" Text="Register" OnClick="btnRegister_Click"/>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</asp:Content>
