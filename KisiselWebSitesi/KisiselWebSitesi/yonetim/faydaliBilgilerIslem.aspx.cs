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
    public partial class faydaliBilgilerIslem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void gredIcerikler_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (gredIcerikler.SelectedIndex > -1) // seçili sayfa var
            {
                SqlConnection baglanti = new SqlConnection(WebConfigurationManager.ConnectionStrings["KisiselWebSitesiConnectionString"].ConnectionString);
                SqlDataAdapter dap = new SqlDataAdapter("Select * from bilgiler where bilgiler_id=@bilgiler_id and silindi=0", baglanti);
                dap.SelectCommand.Parameters.AddWithValue("bilgiler_id", gredIcerikler.SelectedRow.Cells[1].Text);
                DataTable dtIcerik = new DataTable();

                try
                {
                    baglanti.Open();
                    dap.Fill(dtIcerik);
                    baglanti.Close();
                }
                catch
                { }
                if (dtIcerik.Rows.Count > 0) //kayıt bulundu
                {
                    txtBaslik.Text = dtIcerik.Rows[0]["bilgiler_basligi"].ToString();
                    txtSira.Text = dtIcerik.Rows[0]["sira"].ToString();
                    fckIcerik.Value = dtIcerik.Rows[0]["bilgiler_icerigi"].ToString();
                    chkYayinda.Checked = Convert.ToBoolean(dtIcerik.Rows[0]["aktif"].ToString());




                }
            }
        }

        protected void btnYeni_Click(object sender, EventArgs e)
        {
            bosalt();
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            if (gredIcerikler.SelectedIndex > -1) //seçili satırdan güncelleme
            {
                sdsIcerikler.UpdateParameters["bilgiler_id"].DefaultValue = gredIcerikler.SelectedRow.Cells[1].Text;
                sdsIcerikler.UpdateParameters["bilgiler_icerigi"].DefaultValue = fckIcerik.Value;
                if (sdsIcerikler.Update() > 0)
                {
                    lblMesaj.Text = "İçerik başarıyla güncellendi.";
                    sdsIcerikler.DataBind();
                    gredIcerikler.DataBind();
                }
                else
                {
                    lblMesaj.Text = "Güncelleme işlemi tamamlanamadı !";
                    return;
                }
            }
            else //seçili satır yok, ekleme işlemi yapılacak
            {

                sdsIcerikler.InsertParameters["bilgiler_icerigi"].DefaultValue = fckIcerik.Value;
                if (sdsIcerikler.Insert() > 0)
                {
                    lblMesaj.Text = "İçerik başarıyla eklendi.";
                    sdsIcerikler.DataBind();
                    gredIcerikler.DataBind();
                }
                else
                {
                    lblMesaj.Text = "Ekleme işlemi tamamlanamadı !";
                    return;
                }
            }
        }

        private void bosalt()
        {
            txtBaslik.Text = "";
            txtSira.Text = "";
            fckIcerik.Value = "";
            chkYayinda.Checked = false;

            gredIcerikler.SelectedIndex = -1;
            txtBaslik.Focus();

        }

        protected void btnSil_Click(object sender, EventArgs e)
        {
            if (gredIcerikler.SelectedIndex > -1)
            {
                sdsIcerikler.DeleteParameters["bilgiler_id"].DefaultValue = gredIcerikler.SelectedRow.Cells[1].Text;
                if (sdsIcerikler.Delete() > 0)
                {
                    lblMesaj.Text = "İçerik başarıyla silindi.";
                    bosalt();
                }
                else
                {
                    lblMesaj.Text = "Silme işlemi tamamlanamadı !";
                    return;
                }
                //sdsIcerikler.Delete();
            }
            else
            {
                lblMesaj.Text = "Lütfen silinecek sayfayı seçiniz !";
                return;
            }
        }

    }
}
