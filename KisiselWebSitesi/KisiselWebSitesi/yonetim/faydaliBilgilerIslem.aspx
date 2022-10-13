<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.Master" AutoEventWireup="true" CodeBehind="faydaliBilgilerIslem.aspx.cs" Inherits="KisiselWebSitesi.yonetim.faydaliBilgilerIslem" %>
<%@ Register assembly="FredCK.FCKeditorV2" namespace="FredCK.FCKeditorV2" tagprefix="FCKeditorV2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Faydalı Bilgiler</h1>

    </div>
     <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Tüm İçerikler</h6>
        </div>
        <div class="card-body">
            <asp:GridView ID="gredIcerikler" runat="server" AutoGenerateColumns="False" DataKeyNames="bilgiler_id" DataSourceID="sdsIcerikler" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" Width="80%" OnSelectedIndexChanged="gredIcerikler_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="bilgiler_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="bilgiler_id" />
                    <asp:BoundField DataField="bilgiler_basligi" HeaderText="BAŞLIK" SortExpression="bilgiler_basligi" />
                    <asp:CheckBoxField DataField="aktif" HeaderText="YAYINDA" SortExpression="aktif" />
                    <asp:BoundField DataField="sira" HeaderText="SIRA" SortExpression="sira" />
                    <asp:BoundField DataField="eklenme_tarihi" DataFormatString="{0:dd/MM/yyyy}" HeaderText="EKLENME TARİHİ" SortExpression="eklenme_tarihi" />
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
            <asp:SqlDataSource runat="server" ID="sdsIcerikler" ConnectionString='<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>' DeleteCommand="update [Bilgiler] set silindi = 1 WHERE [bilgiler_id] = @bilgiler_id" InsertCommand="INSERT INTO [Bilgiler] ([bilgiler_basligi], [bilgiler_icerigi], [aktif], [silindi], [sira], [eklenme_tarihi]) VALUES (@bilgiler_basligi, @bilgiler_icerigi, @aktif, 0, @sira, getdate())" SelectCommand="SELECT * FROM [Bilgiler] WHERE ([silindi] = @silindi) ORDER BY [bilgiler_basligi]" UpdateCommand="UPDATE [Bilgiler] SET [bilgiler_basligi] = @bilgiler_basligi, [bilgiler_icerigi] = @bilgiler_icerigi, [aktif] = @aktif, [sira] = @sira, [eklenme_tarihi] = getdate() WHERE [bilgiler_id] = @bilgiler_id">
                <DeleteParameters>
                    <asp:Parameter Name="bilgiler_id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtBaslik" Name="bilgiler_basligi" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="bilgiler_icerigi" Type="String" />
                    <asp:ControlParameter ControlID="chkYayinda" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="txtSira" Name="sira" PropertyName="Text" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtBaslik" Name="bilgiler_basligi" PropertyName="Text" />
                    <asp:ControlParameter ControlID="chkYayinda" Name="aktif" PropertyName="Checked" />
                    <asp:ControlParameter ControlID="txtSira" Name="sira" PropertyName="Text" />
                    <asp:Parameter Name="bilgiler_id"></asp:Parameter>
                    <asp:Parameter Name="bilgiler_icerigi"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="pnlDetay" runat="server" BorderStyle="Solid" GroupingText="Sayfa Oluştur">
                &nbsp;&nbsp;&nbsp;
                <br />
                &nbsp; Başlık:&nbsp;&nbsp;   <asp:TextBox ID="txtBaslik" runat="server" CssClass="form-control" Width="941px" ></asp:TextBox><br />
                &nbsp;
                <br />
                &nbsp;&nbsp; Sıra: <asp:TextBox ID="txtSira" runat="server" CssClass="form-control" Width="947px" ></asp:TextBox>
                <br />
                &nbsp;&nbsp; Yayında:&nbsp;  <asp:CheckBox ID="chkYayinda" runat="server" Text="Evet" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                &nbsp;<br /> &nbsp; İçerik:<FCKeditorV2:FCKeditor ID="fckIcerik" runat="server" Height="400px" Width="80%">
                </FCKeditorV2:FCKeditor>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnYeni" runat="server" CssClass="btn btn-primary" OnClick="btnYeni_Click" Text="Yeni" />
                &nbsp;&nbsp;<asp:Button ID="btnKaydet" runat="server" CssClass="btn btn-success" OnClick="btnKaydet_Click" Text="Kaydet" />&nbsp;
                <asp:Button ID="btnSil" runat="server" CssClass="btn btn-danger" OnClick="btnSil_Click" OnClientClick="return confirm (&quot;Silmek istediğinize emin misiniz ?&quot;)" Text="Sil" Width="52px" />
                &nbsp;&nbsp;
                <asp:Label ID="lblMesaj" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                <br /> <br />
            </asp:Panel>
        </div>
    </div>
</asp:Content>

