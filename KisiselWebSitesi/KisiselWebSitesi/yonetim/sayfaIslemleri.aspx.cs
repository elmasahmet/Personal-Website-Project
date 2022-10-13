using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KisiselWebSitesi.yonetim
{
    public partial class sayfaIslemleri : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSil_Click(object sender, EventArgs e)
        {
            if (grdSayfalar.SelectedIndex > -1)
            {
                sdsSayfalar.DeleteParameters["sayfa_id"].DefaultValue = grdSayfalar.SelectedRow.Cells[1].Text;
                if (sdsSayfalar.Delete() > 0)
                {
                    lblMesaj.Text = "Sayfa başarıyla silindi.";
                    bosalt();
                }
                else
                {
                    lblMesaj.Text = "Silme işlemi tamamlanamadı !";
                    return;
                }
                //sdsSayfalar.Delete();
            }
            else
            {
                lblMesaj.Text = "Lütfen silinecek sayfayı seçiniz !";  
                return;
            }
        }

        private void bosalt()
        {
            txtBaslik.Text = "";
            txtSira.Text = "";
            fckIcerik.Value = "";
            chkYayinda.Checked = false;
            ddlUst.DataBind();
            ddlUst.SelectedValue = null;
            grdSayfalar.SelectedIndex = -1;
            txtBaslik.Focus();

        }

        protected void btnYeni_Click(object sender, EventArgs e)
        {
            bosalt();   
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            if (grdSayfalar.SelectedIndex > -1) //seçili satırdan güncelleme
            {
                sdsSayfalar.UpdateParameters["sayfa_id"].DefaultValue = grdSayfalar.SelectedRow.Cells[1].Text;
                sdsSayfalar.UpdateParameters["sayfa_icerigi"].DefaultValue = fckIcerik.Value;
                if (sdsSayfalar.Update() > 0)
                {
                    lblMesaj.Text = "Sayfa başarıyla güncellendi.";
                    sdsSayfalar.DataBind();
                    grdSayfalar.DataBind();
                }
                else
                {
                    lblMesaj.Text = "Güncelleme işlemi tamamlanamadı !";
                    return;
                }
            }
            else //seçili satır yok, ekleme işlemi yapılacak
            {
               
                sdsSayfalar.InsertParameters["sayfa_icerigi"].DefaultValue = fckIcerik.Value;
                if (sdsSayfalar.Insert() > 0)
                {
                    lblMesaj.Text = "Sayfa başarıyla eklendi.";
                    sdsSayfalar.DataBind();
                    grdSayfalar.DataBind();
                }
                else
                {
                    lblMesaj.Text = "Ekleme işlemi tamamlanamadı !";
                    return;
                }
            }
        }

        protected void grdSayfalar_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grdSayfalar.SelectedIndex > -1) // seçili sayfa var
            {
                SqlConnection baglanti = new SqlConnection(WebConfigurationManager.ConnectionStrings["KisiselWebSitesiConnectionString"].ConnectionString);
                SqlDataAdapter dap = new SqlDataAdapter("Select * from sayfalar where sayfa_id=@sayfa_id and silindi=0",baglanti);
                dap.SelectCommand.Parameters.AddWithValue("sayfa_id",grdSayfalar.SelectedRow.Cells[1].Text);
                DataTable dtIcerik = new DataTable();

                try
                {
                    baglanti.Open();
                    dap.Fill(dtIcerik);
                    baglanti.Close();
                }
                catch
                { }
                if (dtIcerik.Rows.Count>0) //kayıt bulundu
                {
                    txtBaslik.Text = dtIcerik.Rows[0]["sayfa_basligi"].ToString(); 
                    txtSira.Text = dtIcerik.Rows[0]["sira"].ToString(); 
                    fckIcerik.Value = dtIcerik.Rows[0]["sayfa_icerigi"].ToString();
                    chkYayinda.Checked = Convert.ToBoolean(dtIcerik.Rows[0]["aktif"].ToString());

                    ddlUst.DataBind();
                    ddlUst.SelectedValue = dtIcerik.Rows[0]["ust_id"].ToString(); 
                }  

                   
            }



           
        }
    }
}