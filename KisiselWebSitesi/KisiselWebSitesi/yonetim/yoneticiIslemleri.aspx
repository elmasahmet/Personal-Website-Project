<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.Master" AutoEventWireup="true" CodeBehind="yoneticiIslemleri.aspx.cs" Inherits="KisiselWebSitesi.yonetim.yoneticiIslemleri" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Kullanıcı İşlemleri</h1>
                     
                    </div>
      <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Tüm Yöneticiler</h6>
        </div>
        <div class="card-body">
            <asp:GridView ID="grdYonetici" runat="server" AutoGenerateColumns="False" DataKeyNames="yönetici_ID" DataSourceID="sdsYonetici" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" Width="80%" OnSelectedIndexChanged="grdSayfalar_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="yönetici_ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="yönetici_ID" />
                    <asp:BoundField DataField="adi" HeaderText="Adı" SortExpression="adi" />
                    <asp:BoundField DataField="soyadi" HeaderText="Soyadı" SortExpression="soyadi" />
                    <asp:BoundField DataField="eposta" HeaderText="E-Posta" SortExpression="eposta" />
                    <asp:CheckBoxField DataField="aktif" HeaderText="Aktif" SortExpression="aktif" />
                    <asp:BoundField DataField="yetki" HeaderText="Yetki" SortExpression="yetki" />
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
            <asp:SqlDataSource ID="sdsYonetici" runat="server" ConnectionString="<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>" DeleteCommand="update [yonetici] set silindi = 1 WHERE [yönetici_ID] = @yönetici_ID" InsertCommand="INSERT INTO [yonetici] ([adi], [soyadi], [eposta], [parola], [aktif], [silindi], [yetki]) VALUES (@adi, @soyadi, @eposta, @parola, @aktif, 0, @yetki)" SelectCommand="SELECT * FROM [yonetici] WHERE ([silindi] = @silindi) ORDER BY [adi], [soyadi], [eposta]" UpdateCommand="UPDATE [yonetici] SET [adi] = @adi, [soyadi] = @soyadi, [eposta] = @eposta, [parola] = @parola, [aktif] = @aktif,[yetki] = @yetki WHERE [yönetici_ID] = @yönetici_ID">
                <DeleteParameters>
                    <asp:Parameter Name="yönetici_ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtAdi" Name="adi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtSoyadi" Name="soyadi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtEposta" Name="eposta" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="parola" Type="String" />
                    <asp:ControlParameter ControlID="chkAktif" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="ddlYetki" Name="yetki" PropertyName="SelectedValue" Type="Byte" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtAdi" Name="adi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtSoyadi" Name="soyadi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtEposta" Name="eposta" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="parola" Type="String" />
                    <asp:ControlParameter ControlID="chkAktif" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="ddlYetki" Name="yetki" PropertyName="SelectedValue" Type="Byte" />
                    <asp:Parameter Name="yönetici_ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsYoneticiGuncelle" runat="server" ConnectionString="<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>" DeleteCommand="update [yonetici] set silindi = 1 WHERE [yönetici_ID] = @yönetici_ID" InsertCommand="INSERT INTO [yonetici] ([adi], [soyadi], [eposta], [parola], [aktif], [silindi], [yetki]) VALUES (@adi, @soyadi, @eposta, @parola, @aktif, 0, @yetki)" SelectCommand="SELECT * FROM [yonetici] WHERE ([silindi] = @silindi) ORDER BY [adi], [soyadi], [eposta]" UpdateCommand="UPDATE [yonetici] SET [adi] = @adi, [soyadi] = @soyadi, [eposta] = @eposta, [aktif] = @aktif, [yetki] = @yetki WHERE [yönetici_ID] = @yönetici_ID">
                <DeleteParameters>
                    <asp:Parameter Name="yönetici_ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtAdi" Name="adi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtSoyadi" Name="soyadi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtEposta" Name="eposta" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="parola" Type="String" />
                    <asp:ControlParameter ControlID="chkAktif" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="ddlYetki" Name="yetki" PropertyName="SelectedValue" Type="Byte" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtAdi" Name="adi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtSoyadi" Name="soyadi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtEposta" Name="eposta" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="chkAktif" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="ddlYetki" Name="yetki" PropertyName="SelectedValue" Type="Byte" />
                    <asp:Parameter Name="yönetici_ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <asp:Panel ID="pnlDetay" runat="server" BorderStyle="Solid" GroupingText="Sayfa Oluştur">
                &nbsp;&nbsp;&nbsp;
                <br />
                &nbsp; Adı:<asp:TextBox ID="txtAdi" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
                &nbsp; Soyadı:&nbsp;&nbsp;
                <asp:TextBox ID="txtSoyadi" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
                &nbsp; E-Posta:&nbsp;
                <asp:TextBox ID="txtEposta" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
                &nbsp;&nbsp;<br /> &nbsp; Yetki:
                <asp:DropDownList ID="ddlYetki" runat="server" CssClass="form-control">
                    <asp:ListItem Value="1">Sistem Yöneticisi</asp:ListItem>
                    <asp:ListItem Value="2">Birim Kullanıcısı</asp:ListItem>
                </asp:DropDownList>
                <br />
                &nbsp;&nbsp;Aktif:&nbsp;
                <asp:CheckBox ID="chkAktif" runat="server" CssClass="form-control" Text="Evet" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />&nbsp;&nbsp; Parola: (Parola değiştirme işlemi yapmayacaksanız boş bırakınız)<asp:TextBox ID="txtParola" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                &nbsp; Parola(Tekrar):<asp:TextBox ID="txtParolaTekrar" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                <br />
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnYeni" runat="server" CssClass="btn btn-primary" OnClick="btnYeni_Click" Text="Yeni" />
                &nbsp;&nbsp;<asp:Button ID="btnKaydet" runat="server" CssClass="btn btn-success" OnClick="btnKaydet_Click" Text="Kaydet" />
                &nbsp;
                <asp:Button ID="btnSil" runat="server" CssClass="btn btn-danger" OnClick="btnSil_Click" OnClientClick="return confirm (&quot;Silmek istediğinize emin misiniz ?&quot;)" Text="Sil" Width="52px" />
                &nbsp;&nbsp;
                <asp:Label ID="lblMesaj" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                <br />
                <br />
            </asp:Panel>
        </div>
    </div>
</asp:Content>
