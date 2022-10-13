<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.Master" AutoEventWireup="true" CodeBehind="sayfaIslemleri.aspx.cs" Inherits="KisiselWebSitesi.yonetim.sayfaIslemleri" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1>Sayfa İşlemleri</h1>

    </div>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Tüm Sayfalar</h6>
        </div>
        <div class="card-body">
            <asp:GridView ID="grdSayfalar" runat="server" AutoGenerateColumns="False" DataKeyNames="sayfa_id" DataSourceID="sdsSayfalar" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" Width="80%" OnSelectedIndexChanged="grdSayfalar_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True">
                        <ItemStyle Width="50px" />
                    </asp:CommandField>
                    <asp:BoundField DataField="sayfa_id" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="sayfa_id">
                        <ItemStyle Width="50px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sayfa_basligi" HeaderText="Başlık" SortExpression="sayfa_basligi">
                        <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="aktif" HeaderText="Yayında" SortExpression="aktif">
                        <ItemStyle Width="50px" />
                    </asp:CheckBoxField>
                    <asp:BoundField DataField="sira" HeaderText="Sıra" SortExpression="sira">
                        <ItemStyle Width="50px" />
                    </asp:BoundField>
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
            <asp:SqlDataSource runat="server" ID="sdsSayfalar" ConnectionString='<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>' DeleteCommand="update [Sayfalar] set silindi = 1 WHERE [sayfa_id] = @sayfa_id" InsertCommand="INSERT INTO [Sayfalar] ([ust_id], [sayfa_basligi], [sayfa_icerigi], [aktif], [silindi], [sira]) VALUES (@ust_id, @sayfa_basligi, @sayfa_icerigi, @aktif, 0, @sira)" SelectCommand="SELECT * FROM [Sayfalar] WHERE ([silindi] = @silindi) ORDER BY [sayfa_basligi]" UpdateCommand="UPDATE [Sayfalar] SET [ust_id] = @ust_id, [sayfa_basligi] = @sayfa_basligi, [sayfa_icerigi] = @sayfa_icerigi, [aktif] = @aktif, [sira] = @sira WHERE [sayfa_id] = @sayfa_id">
                <DeleteParameters>
                    <asp:Parameter Name="sayfa_id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="ddlUst" Name="ust_id" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="txtBaslik" Name="sayfa_basligi" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="sayfa_icerigi" Type="String"></asp:Parameter>
                    <asp:ControlParameter ControlID="chkYayinda" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="txtSira" Name="sira" PropertyName="Text" Type="Int32" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="ddlUst" Name="ust_id" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="txtBaslik" Name="sayfa_basligi" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="sayfa_icerigi" Type="String"></asp:Parameter>
                    <asp:ControlParameter ControlID="chkYayinda" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="txtSira" Name="sira" PropertyName="Text" Type="Int32" />
                    <asp:Parameter Name="sayfa_id" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="pnlDetay" runat="server" BorderStyle="Solid" GroupingText="Sayfa Oluştur">
                &nbsp;&nbsp;&nbsp;
                <br />
                &nbsp; Başlık:&nbsp;&nbsp;  
                <asp:TextBox ID="txtBaslik" runat="server" CssClass="form-control" Width="941px"></asp:TextBox><br />
                &nbsp; Üst Menü:&nbsp;&nbsp; 
                <asp:DropDownList CssClass="form-control" ID="ddlUst" runat="server" DataSourceID="sdsUstMenuler" DataTextField="sayfa_basligi" DataValueField="sayfa_id" Width="163px"></asp:DropDownList>
                <asp:SqlDataSource ID="sdsUstMenuler" runat="server" ConnectionString="<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>" SelectCommand="select top (1) NULL as sayfa_id,'Üst Sayfa Yok' sayfa_basligi from sayfalar
                 union all select sayfa_id, sayfa_basligi from sayfalar where ust_id is NULL"></asp:SqlDataSource>
                <br />
                &nbsp;&nbsp; Sıra:
                <asp:TextBox ID="txtSira" runat="server" CssClass="form-control" Width="947px"></asp:TextBox>
                <br />
                &nbsp;&nbsp; Yayında:&nbsp; 
                <asp:CheckBox ID="chkYayinda" runat="server" Text="Evet" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                &nbsp;<br />
                &nbsp; İçerik:<FCKeditorV2:FCKeditor ID="fckIcerik" runat="server" Height="400px" Width="80%">
                </FCKeditorV2:FCKeditor>
                <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnYeni" runat="server" CssClass="btn btn-primary" OnClick="btnYeni_Click" Text="Yeni" />
                &nbsp;&nbsp;<asp:Button ID="btnKaydet" runat="server" CssClass="btn btn-success" OnClick="btnKaydet_Click" Text="Kaydet" />&nbsp;
                <asp:Button ID="btnSil" runat="server" CssClass="btn btn-danger" OnClick="btnSil_Click" OnClientClick="return confirm (&quot;Silmek istediğinize emin misiniz ?&quot;)" Text="Sil" Width="52px" />
                &nbsp;&nbsp;
                <asp:Label ID="lblMesaj" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                <br />
                <br />
            </asp:Panel>
        </div>
    </div>
</asp:Content>
