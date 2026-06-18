using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UrbanKicks
{
    public partial class User : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] != null)
                {
                    lblWelcome.Text = "Welcome, " + Session["Username"].ToString();
                    lblWelcome.Visible = true;
                }
                else
                {
                    lblWelcome.Visible = false;
                }
                UpdateCartCount();
            }
        }

        public void UpdateCartCount()
        {
            // Retrieve cart from session
            List<Cart.CartItem> cart = Session["cart"] as List<Cart.CartItem>;

            // Get the total count of products
            int cartCount = (cart != null) ? cart.Count : 0;

            // Update label for cart count
            if (cartCount > 0)
            {
                cartCountBadge.Text = cartCount.ToString();
                cartCountBadge.Visible = true; // Show count only if cart is not empty
            }
            else
            {
                cartCountBadge.Visible = false; // Hide count when cart is empty
            }
        }

    }
}