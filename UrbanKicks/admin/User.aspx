<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="UrbanKicks.admin.User" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <section class="tab-components">
        <div class="container-fluid">
            <div class="title-wrapper pt-30">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title mb-30">
                            <h2>Total Users</h2>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="breadcrumb-wrapper mb-30">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="Dashboard.aspx">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">Users</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tables-wrapper">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card-style mb-30">
                            <h6 class="mb-10">Users List</h6>
                            <div class="table-wrapper table-responsive">
                                <asp:GridView ID="gvUsers" runat="server"  AutoGenerateColumns="False" GridLines="None" CssClass="table table-striped table-bordered table-item-center" HeaderStyle-CssClass="table-header">
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Id" />
                                        <asp:BoundField DataField="username" HeaderText="Username" />
                                        <asp:BoundField DataField="password" HeaderText="Password" />
                                        <asp:BoundField DataField="fname" HeaderText="First Name" />
                                        <asp:BoundField DataField="lname" HeaderText="Last Name" />
                                        <asp:BoundField DataField="phone" HeaderText="Phone Number" />
                                        <asp:BoundField DataField="email" HeaderText="Email" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
