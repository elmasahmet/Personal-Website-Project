<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.Master" AutoEventWireup="true" CodeBehind="mesajlar.aspx.cs" Inherits="KisiselWebSitesi.yonetim.mesajlar" %>
<%@ Register assembly="FredCK.FCKeditorV2" namespace="FredCK.FCKeditorV2" tagprefix="FCKeditorV2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Mesaj İşlemleri</h1>
                     
                    </div>
    <asp:GridView ID="grdMesajlar" runat="server" AutoGenerateColumns="False" DataKeyNames="mesaj_id" DataSourceID="sdsMesajlar" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grdMesajlar_SelectedIndexChanged" Width="90%">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="mesaj_id" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="mesaj_id"></asp:BoundField>
            <asp:BoundField DataField="mesaj_basligi" HeaderText="Başlık" SortExpression="mesaj_basligi"></asp:BoundField>
            <asp:BoundField DataField="mesaj_icerigi" HeaderText="mesaj_icerigi" SortExpression="mesaj_icerigi"></asp:BoundField>
            <asp:CheckBoxField DataField="cevaplandi" HeaderText="Cevaplandı" SortExpression="cevaplandi"></asp:CheckBoxField>
            <asp:BoundField DataField="gonderilme_tarihi" HeaderText="Tarih" SortExpression="gonderilme_tarihi"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_ip" HeaderText="IP" SortExpression="ekleyen_ip"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_adisoyadi" HeaderText="Adı Soyadı" SortExpression="ekleyen_adisoyadi"></asp:BoundField>
            <asp:BoundField DataField="bilgiler_id" HeaderText="bilgiler_id" SortExpression="bilgiler_id"></asp:BoundField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="sdsMesajlar" ConnectionString='<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>' SelectCommand="SELECT * FROM [GelenMesajlar] WHERE ([silindi] = 0) ORDER BY [cevaplandi], [gonderilme_tarihi] DESC" DeleteCommand="update [GelenMesajlar] set silindi = 1 WHERE [mesaj_id] = @mesaj_id" InsertCommand="INSERT INTO [GelenMesajlar] ([mesaj_basligi], [mesaj_icerigi], [cevaplandi], [silindi], [gonderilme_tarihi], [ekleyen_ip], [ekleyen_eposta], [ekleyen_adisoyadi], [bilgiler_id]) VALUES (@mesaj_basligi, @mesaj_icerigi, @cevaplandi, @silindi, @gonderilme_tarihi, @ekleyen_ip, @ekleyen_eposta, @ekleyen_adisoyadi, @bilgiler_id)" UpdateCommand="UPDATE [GelenMesajlar] SET  [cevaplandi] = @cevaplandi WHERE [mesaj_id] = @mesaj_id">
        <DeleteParameters>
            <asp:Parameter Name="mesaj_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="mesaj_basligi" Type="String" />
            <asp:Parameter Name="mesaj_icerigi" Type="String" />
            <asp:Parameter Name="cevaplandi" Type="Boolean" />
            <asp:Parameter Name="silindi" Type="Boolean" />
            <asp:Parameter Name="gonderilme_tarihi" Type="DateTime" />
            <asp:Parameter Name="ekleyen_ip" Type="String" />
            <asp:Parameter Name="ekleyen_eposta" Type="String" />
            <asp:Parameter Name="ekleyen_adisoyadi" Type="String" />
            <asp:Parameter Name="bilgiler_id" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="chkCevaplandi" Name="cevaplandi" PropertyName="Checked" />
            <asp:Parameter Name="mesaj_id" />
        </UpdateParameters>
    </asp:SqlDataSource>
       <asp:Panel ID="pnlDetay" runat="server" BorderStyle="Solid" GroupingText="Mesaj Detayı" Height="361px" Width="1114px">
           &nbsp; Konu:&nbsp;<asp:Label ID="lblBaslik" runat="server"></asp:Label>
           <br />
           &nbsp; İçerik:
           <asp:Literal ID="ltrMesaj" runat="server"></asp:Literal>
           <br />
           &nbsp; Gönderen:
           <asp:Label ID="lblGonderen" runat="server"></asp:Label>
           <br />
           &nbsp; Gönderen E-Posta:
           <asp:Label ID="lblGonderenEposta" runat="server"></asp:Label>
           <br />
           &nbsp; Tarih:
           <asp:Label ID="lblTarih" runat="server"></asp:Label>
           <br />
           &nbsp; IP Adresi:
           <asp:Label ID="lblIPAdresi" runat="server"></asp:Label>
           <br />
           &nbsp; Cevaplandı:<asp:CheckBox ID="chkCevaplandi" runat="server" Text="Evet" />
           <br />
           &nbsp;<br />
           <asp:Button ID="btnKaydet" runat="server" CssClass="btn btn-success" OnClick="btnKaydet_Click" Text="Cevaplandı Olarak İşaretle" Width="239px" />
           <asp:Button ID="btnSil" runat="server" CssClass="btn btn-danger" OnClick="btnSil_Click" OnClientClick="return confirm (&quot;Silmek istediğinize emin misiniz ?&quot;)" Text="Mesajı Sil" Width="149px" />
           &nbsp;&nbsp;
           <asp:Label ID="lblMesaj" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
           <br />
           &nbsp;
           <br />
           &nbsp;
           <br />
           &nbsp;
           <br />
           &nbsp;<br /> &nbsp;
           <br />
           <br />
           <br />
           <br />
           &nbsp;
           <br />
           &nbsp;&nbsp;<br />
       </asp:Panel>
</asp:Content>
