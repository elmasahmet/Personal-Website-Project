using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KisiselWebSitesi.yonetim
{
    public partial class yoneticiIslemleri : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["yetki"].ToString()!="1")
                {
                    Response.Redirect("Default.aspx");
                }
            }
            catch 
            {
                Response.Redirect("../giris.aspx");

            }
        }

        protected void grdSayfalar_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grdYonetici.SelectedIndex > -1) // seçili sayfa var
            {
                SqlConnection baglanti = new SqlConnection(WebConfigurationManager.ConnectionStrings["KisiselWebSitesiConnectionString"].ConnectionString);
                SqlDataAdapter dap = new SqlDataAdapter("Select * from yonetici where yönetici_ID=@yönetici_ID and silindi=0", baglanti);
                dap.SelectCommand.Parameters.AddWithValue("yönetici_ID", grdYonetici.SelectedRow.Cells[1].Text);
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
                    txtAdi.Text = dtIcerik.Rows[0]["adi"].ToString();
                    txtSoyadi.Text = dtIcerik.Rows[0]["soyadi"].ToString();
                    txtEposta.Text = dtIcerik.Rows[0]["eposta"].ToString();
                    chkAktif.Checked = Convert.ToBoolean(dtIcerik.Rows[0]["aktif"].ToString());
                    ddlYetki.SelectedValue = dtIcerik.Rows[0]["yetki"].ToString();






                }
            }
        }

        protected void btnYeni_Click(object sender, EventArgs e)
        {
            bosalt();
            txtAdi.Focus();
        }

        private void bosalt()
        {
            txtAdi.Text = "";
            txtSoyadi.Text = "";
            txtEposta.Text = "";
            chkAktif.Checked = false;
            grdYonetici.SelectedIndex = -1;
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            if (grdYonetici.SelectedIndex==-1) //ekle
            {
                if (txtParola.Text.Trim()!= txtParolaTekrar.Text.Trim())
                {
                    lblMesaj.Text = "Parolalar uyuşmuyor !";
                    return;
                }

                if (txtParola.Text.Trim().Length<8)
                {
                    lblMesaj.Text = "Parola en az 8 karakter olmalıdır !";
                    return;
                }

                sdsYonetici.InsertParameters["parola"].DefaultValue = MD5Sifrele (txtParola.Text.Trim());
                if (sdsYonetici.Insert() > 0)
                {
                    lblMesaj.Text = "Kayıt eklendi.";
                    bosalt();
                }
            }
            else //guncelle
            {
                if (txtParola.Text.Trim().Length==0) //parola eskisi gibi kalacak
                {

                  
                   
                    sdsYoneticiGuncelle.UpdateParameters["yönetici_ID"].DefaultValue = grdYonetici.SelectedRow.Cells[1].Text;
                    if (sdsYoneticiGuncelle.Update() > 0)
                    {
                        lblMesaj.Text = "Kayıt güncellendi";

                    }
                }

                else //parola değişecek
                {

                    if (txtParola.Text.Trim() != txtParolaTekrar.Text.Trim())
                    {
                        lblMesaj.Text = "Parolalar uyuşmuyor !";
                        return;
                    }
                    sdsYonetici.UpdateParameters["parola"].DefaultValue = MD5Sifrele(txtParola.Text.Trim());
                    sdsYonetici.UpdateParameters["yönetici_ID"].DefaultValue = grdYonetici.SelectedRow.Cells[1].Text;
                    if (sdsYonetici.Update() > 0)
                    {
                        lblMesaj.Text = "Kayıt güncellendi";
                       
                    }
                }
            }
        }

        protected void btnSil_Click(object sender, EventArgs e)
        {
            if (grdYonetici.SelectedIndex>-1)
            {
                sdsYonetici.DeleteParameters["yönetici_ID"].DefaultValue = grdYonetici.SelectedRow.Cells[1].Text;
                if (sdsYonetici.Delete()>0)
                {
                    lblMesaj.Text = "Kayıt silindi.";
                    bosalt();
                }

            }

            else
            {
                lblMesaj.Text = "Silinecek kaydı seçiniz.";
                return;
            }
        }

        public static string MD5Sifrele(string sifrelenecekMetin)
        {

            // MD5CryptoServiceProvider sınıfının bir örneğini oluşturduk.
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            //Parametre olarak gelen veriyi byte dizisine dönüştürdük.
            byte[] dizi = Encoding.UTF8.GetBytes(sifrelenecekMetin);
            //dizinin hash'ini hesaplattık.
            dizi = md5.ComputeHash(dizi);
            //Hashlenmiş verileri depolamak için StringBuilder nesnesi oluşturduk.
            StringBuilder sb = new StringBuilder();
            //Her byte'i dizi içerisinden alarak string türüne dönüştürdük.

            foreach (byte ba in dizi)
            {
                sb.Append(ba.ToString("x2").ToLower());
            }

            //hexadecimal(onaltılık) stringi geri döndürdük.
            return sb.ToString();
        }

    }
}
