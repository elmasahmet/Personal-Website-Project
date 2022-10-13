<%@ Page Title="" Language="C#" MasterPageFile="~/anaSablon.Master" AutoEventWireup="true" CodeBehind="iletisim.aspx.cs" Inherits="KisiselWebSitesi.iletisim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
                          </asp:ScriptManager>
    <section id="contact" class="contact">
      <div class="container">

        <div class="section-title">
          <h2>İletişim</h2>
          <p>Belirtilen adresler üzerinden 7/24 ulaşabilirsiniz.</p>
        </div>
      </div>

      <div>
       <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d195.43775703355928!2d27.05605014336692!3d38.39515396125125!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14bbdc3f593e08ab%3A0xe0c497f92491cc5c!2zQmFsw6dvdmEvxLB6bWly!5e0!3m2!1str!2str!4v1664461267735!5m2!1str!2str" width="100%" height="350" style="border:0;" allowfullscreen="" ></iframe>
      </div>

      <div class="container">
        <div class="row mt-5">

          <div class="col-lg-4">
            <div class="info">
                   <asp:Repeater ID="rptBilgiler" runat="server" DataSourceID="sdsBilgiler">

            <ItemTemplate>
                     <div class="address">
                <i class="bi bi-geo-alt"></i>
                <h4>Lokasyon</h4>
                <p><%#Eval("adres") %></p>
              </div>

              <div class="email">
                <i class="bi bi-envelope"></i>
                <h4>E-Posta:</h4>
                <p><%#Eval("eposta") %></p>
              </div>

              <div class="phone">
                <i class="bi bi-phone"></i>
                <h4>Telefon</h4>
                <p><%#Eval("telefon") %></p>
              </div>
            </ItemTemplate>

        </asp:Repeater>
        <asp:SqlDataSource ID="sdsBilgiler" runat="server" ConnectionString="<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>" SelectCommand="SELECT * FROM [AdminBilgileri]"></asp:SqlDataSource>
          
            </div>

          </div>

          <div class="col-lg-8 mt-5 mt-lg-0">

            <form action="forms/contact.php" method="post" role="form" class="php-email-form">
              <div class="row">
                <div class="col-md-6 form-group">
                    <label for= "txtAdiSoyadi">Ad Soyad</label>
                    <asp:TextBox ID="txtAdiSoyadi" runat="server" Cssclass="form-control" placeholder ="Ad Soyad" ></asp:TextBox>
                 
                </div>
                <div class="col-md-6 form-group mt-3 mt-md-0">
                    <label for= "txtEposta">E-Posta</label>
                     <asp:TextBox ID="txtEposta" runat="server" Cssclass="form-control" placeholder ="E-Posta" ></asp:TextBox>
                 
                </div>
              </div>
              <div class="form-group mt-3">
                  <label for= "txtKonu">Konu</label>
                  <asp:TextBox ID="txtKonu" runat="server" Cssclass="form-control" placeholder ="Konu" ></asp:TextBox>

               
              </div>
              <div class="form-group mt-3">
                  <label for= "txtMesaj">Mesajınız</label>
                  <asp:TextBox ID="txtMesaj" runat="server" Cssclass="form-control" placeholder ="Mesaj" TextMode="MultiLine" ></asp:TextBox>

              </div>

                <div class="form-group mt-3">
                  <label for= "txtIP">IP Adresiniz</label>
                  <asp:label ID="lblIP" runat="server" Text="" CssClass="form-control" ></asp:label>

              </div>
       
              <div class="text-center">
                  <asp:SqlDataSource ID="sdsMesajGonder" runat="server" ConnectionString="<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>" DeleteCommand="DELETE FROM [GelenMesajlar] WHERE [mesaj_id] = @mesaj_id" InsertCommand="INSERT INTO [GelenMesajlar] ([mesaj_basligi], [mesaj_icerigi], [cevaplandi], [silindi], [gonderilme_tarihi], [ekleyen_ip], [ekleyen_eposta], [ekleyen_adisoyadi]) VALUES (@mesaj_basligi, @mesaj_icerigi, 0, 0, getdate(), @ekleyen_ip, @ekleyen_eposta, @ekleyen_adisoyadi)" SelectCommand="SELECT * FROM [GelenMesajlar]" UpdateCommand="UPDATE [GelenMesajlar] SET [mesaj_basligi] = @mesaj_basligi, [mesaj_icerigi] = @mesaj_icerigi, [cevaplandi] = @cevaplandi, [silindi] = @silindi, [gonderilme_tarihi] = @gonderilme_tarihi, [ekleyen_ip] = @ekleyen_ip, [ekleyen_eposta] = @ekleyen_eposta, [ekleyen_adisoyadi] = @ekleyen_adisoyadi, [bilgiler_id] = @bilgiler_id WHERE [mesaj_id] = @mesaj_id">
                      <DeleteParameters>
                          <asp:Parameter Name="mesaj_id" Type="Int32" />
                      </DeleteParameters>
                      <InsertParameters>
                          <asp:ControlParameter ControlID="txtKonu" Name="mesaj_basligi" PropertyName="Text" />
                          <asp:ControlParameter ControlID="txtMesaj" Name="mesaj_icerigi" PropertyName="Text" />
                          <asp:ControlParameter ControlID="lblIP" Name="ekleyen_ip" PropertyName="Text" />
                          <asp:ControlParameter ControlID="txtEposta" Name="ekleyen_eposta" PropertyName="Text" />
                          <asp:ControlParameter ControlID="txtAdiSoyadi" Name="ekleyen_adisoyadi" PropertyName="Text" />
                      </InsertParameters>
                      <UpdateParameters>
                          <asp:Parameter Name="mesaj_basligi" Type="String" />
                          <asp:Parameter Name="mesaj_icerigi" Type="String" />
                          <asp:Parameter Name="cevaplandi" Type="Boolean" />
                          <asp:Parameter Name="silindi" Type="Boolean" />
                          <asp:Parameter Name="gonderilme_tarihi" Type="DateTime" />
                          <asp:Parameter Name="ekleyen_ip" Type="String" />
                          <asp:Parameter Name="ekleyen_eposta" Type="String" />
                          <asp:Parameter Name="ekleyen_adisoyadi" Type="String" />
                          <asp:Parameter Name="bilgiler_id" Type="Int32" />
                          <asp:Parameter Name="mesaj_id" Type="Int32" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                      <ContentTemplate>
                          <asp:Label ID="lblMesaj" runat="server" ForeColor="#CC0000"></asp:Label>
                          
                      </ContentTemplate>
                      <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="btnGonder" />
                      </Triggers>
                  </asp:UpdatePanel>
                  <asp:Button ID="btnGonder" runat="server" Text="Mesaj Gönder" CssClass="btn btn-primary mt-3" OnClick="btnGonder_Click" Height="47px" Width="200px" />
                
            

          </div>

        </div>

      </div>
    </section>
</asp:Content>
