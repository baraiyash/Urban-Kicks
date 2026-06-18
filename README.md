# 👟 Urban Kicks

### A Modern ASP.NET Sneaker Selling Website

Buy Sneakers • Browse Brands • Manage Products • Secure Authentication • Shopping Cart • Checkout System

![ASP.NET](https://img.shields.io/badge/ASP.NET-WebForms-blue)
![SQL Server](https://img.shields.io/badge/Database-SQL%20Server-green)
![Bootstrap](https://img.shields.io/badge/UI-Bootstrap-purple)
![GitHub](https://img.shields.io/badge/Version%20Control-GitHub-black)

---

## 📖 Overview

**Urban Kicks** is an e-commerce web application developed using **ASP.NET Web Forms** and **SQL Server**. The platform allows users to browse sneakers from various brands, add products to their cart, and place orders. It also provides an admin panel for managing products, users, and purchase details.

The website aims to provide a seamless online shopping experience with a clean and responsive user interface.

---

# ✨ Features

## 👤 User Module

* User Registration and Login
* Browse Sneakers by Brand
* Product Details Page
* Add Products to Cart
* Shopping Cart Management
* Checkout System
* Order and Shipping Information
* Responsive User Interface

---

## 🛍️ Product Categories

* Nike
* Adidas
* Asics
* Converse
* New Balance

---

## 👨‍💼 Admin Module

* Secure Admin Login
* Dashboard
* Add New Products
* Update Existing Products
* Manage Products
* View Registered Users
* Purchase Details Management

---

# 🏗️ System Architecture

```
Frontend (ASP.NET Web Forms + Bootstrap)
				│
				▼
Backend (C#)
				│
				▼
Database (SQL Server LocalDB)

```
---

# 🛠️ Tech Stack

## Frontend

* ASP.NET Web Forms
* HTML5
* CSS3
* Bootstrap
* JavaScript

## Backend

* C#

## Database

* SQL Server
* LocalDB (.mdf Database)

## IDE

* Visual Studio 2017

## Version Control

* Git
* GitHub

---

# 📂 Project Structure

```
UrbanKicks/
│
├── UrbanKicks.sln
├── CHANGELOG.md
├── Web.config
├── packages.config
│
├── App_Data/
│     ├── UrbanKicksDB.mdf
│     └── UrbanKicksDB_log.ldf
│
├── admin/
│     ├── Dashboard.aspx
│     ├── AddProducts.aspx
│     ├── ManageProducts.aspx
│     ├── UpdateProducts.aspx
│     ├── PurchaseDetails.aspx
│     └── User.aspx
│
├── assets/
│     ├── css/
│     ├── js/
│     ├── scss/
│     ├── fonts/
│     └── images/
│
├── images/
│
├── Index.aspx
├── Product.aspx
├── Cart.aspx
├── Checkout.aspx
├── OrderAndShipping.aspx
├── Register.aspx
├── SignIn.aspx
├── LoginAdmin.aspx
├── Nike.aspx
├── Adidas.aspx
├── Asics.aspx
├── Converse.aspx
├── NewBalance.aspx
├── About.aspx
├── PrivacyPolicy.aspx
└── TermsAndConditions.aspx

```
---

# 📚 Core Modules

* User Authentication
* Product Management
* Shopping Cart
* Checkout System
* Order Management
* User Management
* Admin Dashboard
* Brand Categories

---

# ⚙️ Installation Guide

## 1️⃣ Clone the Repository

```sh
git clone https://github.com/baraiyash/Urban-Kicks.git

```
Move into the project folder:

```sh
cd Urban-Kicks

```
---

## 2️⃣ Open in Visual Studio

Open:

```
UrbanKicks.sln

```
using **Visual Studio 2017 or above**.

---

## 3️⃣ Restore NuGet Packages

Visual Studio automatically restores packages.

If required:

```
Tools → NuGet Package Manager → Restore Packages

```
---

## 4️⃣ Configure Database

The project uses SQL Server LocalDB.

Database files are located inside:

```
App_Data/
	UrbanKicksDB.mdf
	UrbanKicksDB_log.ldf

```
Open **Server Explorer** in Visual Studio and attach:

```
UrbanKicksDB.mdf

```
---

## 5️⃣ Verify Connection String

Open:

```
Web.config

```
and ensure the connection string points to your database:

```xml
<connectionStrings>
	<add name="UrbanKicksDBConnectionString"
		 connectionString="Data Source=(LocalDB)\MSSQLLocalDB;
		 AttachDbFilename=|DataDirectory|\UrbanKicksDB.mdf;
		 Integrated Security=True"
		 providerName="System.Data.SqlClient"/>
</connectionStrings>

```
---

## 6️⃣ Run the Application

Press:

```
Ctrl + F5

```
or click:

```
Start

```
Visual Studio will launch the application in your browser.

---

# 🔐 User Pages

| Page                 |
| -------------------- |
| Home                 |
| Product Details      |
| Cart                 |
| Checkout             |
| Order and Shipping   |
| Register             |
| Sign In              |
| About                |
| Privacy Policy       |
| Terms and Conditions |

---

# 👨‍💼 Admin Pages

| Page             |
| ---------------- |
| Dashboard        |
| Add Products     |
| Manage Products  |
| Update Products  |
| Purchase Details |
| Users            |

---

# 🚀 Future Enhancements

* Wishlist Functionality
* Product Search and Filters
* Order Tracking
* Razorpay Payment Integration
* Email Notifications
* Product Reviews and Ratings
* Coupon and Discount System
* User Profile Management
* Inventory Management
* Sales Analytics Dashboard

---

# 🧠 Project Highlights

Through the development of this project, I gained hands-on experience in:

* ASP.NET Web Forms Development
* C# Backend Programming
* SQL Server Database Design
* CRUD Operations
* Session Management
* Shopping Cart Functionality
* User Authentication
* Master Pages
* Bootstrap Responsive Design
* Form Validation
* Git and GitHub Version Control
* Debugging and Performance Optimization

---

# 👨‍💻 Author

### Yash Barai

GitHub: https://github.com/baraiyash

---

# ⭐ Support

If you found this project useful, consider giving it a ⭐ on GitHub.

---

# 📜 License

This project was developed for educational and learning purposes.
