<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.Master" AutoEventWireup="true" CodeBehind="YorumIslemleri.aspx.cs" Inherits="KisiselWebSitesi.yonetim.YorumIslemleri" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Yorumlar</h1>
                     
                    </div>
    <asp:GridView ID="grdYorumlar" runat="server" AutoGenerateColumns="False" DataKeyNames="bilgiler_id,yorum_id" DataSourceID="sdsYorumlar" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grdYorumlar_SelectedIndexChanged" Width="90%">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField SelectText="Onayla/Onayı İptal Et" ShowSelectButton="True" />
            <asp:BoundField DataField="yorum_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="yorum_id" />
            <asp:BoundField DataField="bilgiler_basligi" HeaderText="Yorum Yapılan İçerik" SortExpression="bilgiler_basligi"></asp:BoundField>
            <asp:BoundField DataField="yorum_icerigi" HeaderText="Yapılan Yorum" SortExpression="yorum_icerigi"></asp:BoundField>
            <asp:CheckBoxField DataField="onaylandi" HeaderText="Onaylandı" SortExpression="onaylandi"></asp:CheckBoxField>
            <asp:BoundField DataField="eklenme_tarihi" HeaderText="Eklenme Tarihi" SortExpression="eklenme_tarihi"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_ip" HeaderText="IP" SortExpression="ekleyen_ip"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_eposta" HeaderText="E-Posta" SortExpression="ekleyen_eposta"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_adisoyadi" HeaderText="Adı Soyadı" SortExpression="ekleyen_adisoyadi"></asp:BoundField>
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
    <asp:SqlDataSource runat="server" ID="sdsYorumlar" ConnectionString='<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>' SelectCommand="select * from Bilgiler inner join BilgiYorumları on
Bilgiler.bilgiler_id=BilgiYorumları.bilgiler_id where Bilgiler.silindi=0 and
Bilgiler.aktif=1 and BilgiYorumları.silindi=0
order by onaylandi" UpdateCommand="update BilgiYorumları set onaylandi=(onaylandi^1) where yorum_id=@yorum_id">
        <UpdateParameters>
            <asp:Parameter Name="yorum_id" />
        </UpdateParameters>
       </asp:SqlDataSource>
</asp:Content>
