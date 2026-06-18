<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="UrbanKicks.admin.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.lineicons.com/3.0/lineicons.css">
    <link rel="stylesheet" href="assets/css/lineicons.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="section">
            <div class="container-fluid">
                <!-- Title Wrapper -->
               <div class="title-wrapper pt-30">
                    <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title mb-30">
                        <h2>Urban Kicks Dashboard</h2>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="breadcrumb-wrapper mb-30">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a>Dashboard</a>
                            </li>
                            </ol>
                        </nav>
                        </div>
                    </div>
                    </div>
                </div>
                <!-- End Title Wrapper -->

                <div class="row">
                    <!-- Total Products-->
                    <div class="col-xl-3 col-lg-4 col-sm-6">
                        <div class="icon-card mb-30">
                            <div class="icon ">
                                    <a href="ManageProducts.aspx"><i class="fa fa-shopping-cart"></i></a>
                            </div>
                            <div class="content">
                                <h3 class="text-bold mb-10">Total Products</h3>
                                <h3><asp:Label ID="lblFlights" runat="server" CssClass="stat-label" /></h3>
                            </div>
                        </div>
                    </div>

                    <!-- Total Users -->
                    <div class="col-xl-3 col-lg-4 col-sm-6">
                        <div class="icon-card mb-30">
                            <div class="icon teal">
                               <a href="User.aspx"> <i class="fas fa-user"></i> </a>
                            </div>
                            <div class="content">
                                <h3 class="text-bold mb-10">Total Users</h3>
                                <h3><asp:Label ID="lblUsers" runat="server" CssClass="stat-label" /></h3>
                            </div>
                        </div>
                    </div>

                    <!-- Total Orders -->
                    <div class="col-xl-3 col-lg-4 col-sm-6">
                        <div class="icon-card mb-30">
                            <div class="icon teal">
                                <a href="PurchaseDetails.aspx"> <i class="fas fa-truck"></i> </a>
                            </div>
                            <div class="content">
                                <h3 class="text-bold mb-10">Total Orders</h3>
                                <h3><asp:Label ID="lblBookings" runat="server" CssClass="stat-label" /></h3>
                            </div>
                        </div>
                    </div>

                    <!-- Total Brands -->
                    <div class="col-xl-3 col-lg-4 col-sm-6">
                        <div class="icon-card mb-30">
                            <div class="icon teal"> 
                                <i class="fas fa-tags"></i>               
                                
                            </div>
                            <div class="content">
                                <h3 class="text-bold mb-10">Total Brands</h3>
                                <h3><asp:Label ID="lblClasses" runat="server" CssClass="stat-label" /></h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </section>  
</asp:Content>
