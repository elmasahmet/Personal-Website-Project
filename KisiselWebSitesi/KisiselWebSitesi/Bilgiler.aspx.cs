using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KisiselWebSitesi
{
    public partial class Bilgiler : System.Web.UI.Page
    {   
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected string ipNedir()
        {
            string ipaddress;
            ipaddress = Context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (ipaddress == "" || ipaddress == null)
                ipaddress = Context.Request.ServerVariables["REMOTE_ADDR"];
            return ipaddress;
        }

        protected void btnGonder_Click(object sender, EventArgs e)
        {
            if (sdsYorumlar.Insert() > 0)
            {
                lblMesaj.Text = "Yorumunuz gönderildi, yönetici onayından sonra yayınlanacaktır.";
                txtAdiSoyadi.Text = "";
                txtEposta.Text = "";
                txtMesaj.Text = "";
                
            }

            else
            {
                lblMesaj.Text = "Yorumunuz gönderilirken bir hata oluştu, lütfen tekrar deneyiniz.";
            }
        }
    }
}