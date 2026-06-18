<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.Master" AutoEventWireup="true" CodeBehind="PurchaseDetails.aspx.cs" Inherits="UrbanKicks.admin.PurchaseDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="tab-components">
        <div class="container-fluid">
            <div class="title-wrapper pt-30">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <div class="title mb-30">
                            <h2>Total Orders</h2>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="breadcrumb-wrapper mb-30">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="Dashboard.aspx">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">
                                        Orders
                                    </li>
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
                            <h6 class="mb-10">Orders List</h6>

                            <div class="table-wrapper table-responsive">
                                <asp:GridView ID="BookingGrid" runat="server" CssClass="table" AutoGenerateColumns="False"  >
                                <Columns>
                                    <asp:BoundField DataField="username" HeaderText="Username" />
                                    <asp:BoundField DataField="ProductId" HeaderText="Product Id" />
                                    <asp:BoundField DataField="Brand" HeaderText="Brands" />
                                    <asp:BoundField DataField="date_of_purchase" HeaderText="Purchase Date" DataFormatString="{0:yyyy-MM-dd}" />
                                    <asp:BoundField DataField="final_total" HeaderText="Total Price" />
                                    <asp:BoundField DataField="payment_method" HeaderText="Payment Method" />
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
