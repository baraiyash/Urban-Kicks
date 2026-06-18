<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="UrbanKicks.About" %>
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

.about-us {
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

.about-title {
    font-size: 20px;
    font-weight: bold;
    flex: 1;
    text-align: center;
    color: #000;
}

.about-content {
    flex: 3;
}

.about-content p {
    font-size: 16px;
    line-height: 1.6;
    color: #333;
    margin-bottom: 15px;
}

    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="main">
         <section class="about-us">
        <div class="about-title">   ABOUT US
            <img src="images/logo8-without-bg.png" alt="" height="50px">
        </div>
        <div class="about-content">
            <p>
                Our name, <strong>"Urban Kicks"</strong> is an amalgamation of two complete opposite words. 
                At its core, it represents the coming together of different perspectives or tastes bound together 
                by the love for sneakers & street culture.
            </p>
            <p>
                As a community-first sneaker and streetwear boutique in India, we aim to be zeitgeists. With our culture-to-commerce 
                approach, we endeavour to be at the forefront of movements rooted in music, art, fashion and more. 
                Through our platform and reach, we champion inclusivity, individuality and creative expression. 
                Collaborating with creators from all over India and across the world, we create impactful stories and editorial content.
            </p>
            <p>
                The design of our apparel collections pays respect to the culture we come from. 
                This collision of tradition and contemporary silhouettes speaks to our intention of being a streetwear brand from India 
                - connected to our roots, relevant in the now, but creating the future.
            </p>
            <p>
                Since our inception in 2024, we’ve evolved from a sneaker boutique and streetwear brand to become a cultural force that 
                cultivates and shapes both sneakers and pop culture.
            </p>
        </div>
    </section>
    </div>

    
</asp:Content>
