<%@ Page Title="" Language="C#" MasterPageFile="~/anaSablon.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="KisiselWebSitesi.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="breadcrumbs">
        <div class="container">
            <asp:Repeater ID="rptIcerik" runat="server" DataSourceID="sdsIcerik">
                <itemtemplate>
                    <%#Eval ("sayfa_icerigi") %>
                </itemtemplate>

            </asp:Repeater>
        </div>
    </section>
    <asp:SqlDataSource ID="sdsIcerik" runat="server" ConnectionString="<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>" SelectCommand="SELECT * FROM [Sayfalar] WHERE (([aktif] = @aktif) AND ([silindi] = @silindi) AND ([sayfa_id] = @sayfa_id))">
        <selectparameters>
            <asp:Parameter DefaultValue="True" Name="aktif" Type="Boolean" />
            <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean" />
            <asp:QueryStringParameter DefaultValue="1" Name="sayfa_id" QueryStringField="id" Type="Int32" />
        </selectparameters>
    </asp:SqlDataSource>
</asp:Content>
