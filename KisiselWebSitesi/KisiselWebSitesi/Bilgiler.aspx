<%@ Page Title="" Language="C#" MasterPageFile="~/anaSablon.Master" AutoEventWireup="true" CodeBehind="Bilgiler.aspx.cs" Inherits="KisiselWebSitesi.Bilgiler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <section id="faq" class="faq section-bg">
        <div class="container">

            <div class="section-title" style="margin-top: 70px">
                <h2>Faydalı Bilgiler</h2>
                <p>Bunları arıyor olabilirsiniz.</p>
            </div>

            <div class="faq-list">
                <asp:Panel ID="pnlTumBilgiler" runat="server">
                    <ul>
                        <asp:Repeater ID="rptBilgiler" runat="server" DataSourceID="sdsBilgiler">

                            <ItemTemplate>
                                <li>
                                    <i class="bx bx-help-circle icon-help"></i><a href="Bilgiler.aspx?id=<%#Eval("bilgiler_id") %>"><%#Eval("bilgiler_basligi") %><i class="bx bx-chevron-down icon-show"></i><i class="bx bx-chevron-up icon-close"></i></a>

                                </li>
                            </ItemTemplate>

                        </asp:Repeater>

                        <asp:SqlDataSource runat="server" ID="sdsBilgiler" ConnectionString='<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>' SelectCommand="SELECT * FROM [Bilgiler] WHERE (([aktif] = @aktif) AND ([silindi] = @silindi)) ORDER BY [sira]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="True" Name="aktif" Type="Boolean"></asp:Parameter>
                                <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>


                            </SelectParameters>
                        </asp:SqlDataSource>

                    </ul>

                </asp:Panel>

                <asp:Panel ID="pnlSeciliBilgi" runat="server">   
                    <ul>
                        <asp:Repeater ID="rptSeciliBilgi" runat="server" DataSourceID="sdsSeciliBilgiler">

                            <ItemTemplate>
                                <li>

                                    <h3><%#Eval("bilgiler_basligi")%> </h3>
                                    <div><%#Eval("bilgiler_icerigi")%> </div>


                                </li>
                            </ItemTemplate>

                        </asp:Repeater>

                        <asp:Repeater ID="rptYorumlar" runat="server" DataSourceID="sdsYorumlar">
                            <HeaderTemplate>

                                <br />
                                <h5> Yorumlar:</h5><br />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <span style="font-size: 15px"><%#Eval("yorum_icerigi") %><br />
                                </span>
                                <span style="font-size: 10px"><%#Eval("ekleyen_adisoyadi") %> tarafından <%#Eval("eklenme_tarihi", "{0:dd/MM/yyyy hh:mm}") %> tarihinde eklendi. </span>
                            </ItemTemplate>
                            <SeparatorTemplate>
                                <br />
                            </SeparatorTemplate>
                        </asp:Repeater>

                        <asp:Panel ID="pnlYorumYap" runat="server" GroupingText="Yorum Yap" BorderStyle="Ridge" Height="399px" style="margin-left: 0px; margin-top: 27px" Width="1237px">
                                <div class="row">
                            <div class="col-lg-8 mt-5 mt-lg-0">

                                <form action="forms/contact.php" method="post" role="form" class="php-email-form">
                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            &nbsp;&nbsp;
                                            <label for="txtAdiSoyadi">
                                            &nbsp; Ad Soyad</label>
                                            <asp:TextBox ID="txtAdiSoyadi" runat="server" CssClass="form-control" placeholder="Ad Soyad"></asp:TextBox>

                                        </div>
                                        <div class="col-md-6 form-group mt-3 mt-md-0">
                                            <label for="txtEposta">&nbsp;&nbsp;&nbsp;&nbsp; E-Posta</label>
                                            <asp:TextBox ID="txtEposta" runat="server" CssClass="form-control" placeholder="E-Posta"></asp:TextBox>
                                            
                                        </div>
                                    </div>

                                    <div class="form-group mt-3">
                                        <label for="txtMesaj">&nbsp;&nbsp;&nbsp;&nbsp; Yorum</label>
                                        <asp:TextBox ID="txtMesaj" runat="server" CssClass="form-control" placeholder="Mesaj" TextMode="MultiLine"></asp:TextBox>

                                    </div>

                                    <div class="form-group mt-3">
                                        <label for="txtIP">&nbsp;&nbsp;&nbsp;&nbsp; IP Adresiniz</label>
                                        <br />
                                        <asp:Label ID="lblIP" runat="server" CssClass="form-control" Height="37px" Width="1032px"></asp:Label>

                                    </div>

                                    <div class="text-center">

                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <asp:Label ID="lblMesaj" runat="server" ForeColor="#CC0000"></asp:Label>

                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnGonder" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:Button ID="btnGonder" runat="server" Text="Yorum Gönder" CssClass="btn btn-primary mt-3" OnClick="btnGonder_Click" Width="219px" />



                                    </div>
                            </div>
                        </div>
                        </asp:Panel>
                    
            </div>


            <asp:SqlDataSource runat="server" ID="sdsYorumlar" ConnectionString='<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>' SelectCommand="SELECT * FROM [BilgiYorumları] WHERE (([bilgiler_id] = @bilgiler_id) AND ([onaylandi] = @onaylandi) AND ([silindi] = @silindi)) ORDER BY [eklenme_tarihi] DESC" InsertCommand="insert into BilgiYorumları (yorum_icerigi,eklenme_tarihi,ekleyen_ip,ekleyen_eposta,ekleyen_adisoyadi,bilgiler_id) values(@yorum_icerigi,getdate(),@ekleyen_ip,@ekleyen_eposta,@ekleyen_adisoyadi,@bilgiler_id)">
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtMesaj" Name="yorum_icerigi" PropertyName="Text" />
                    <asp:ControlParameter ControlID="lblIP" Name="ekleyen_ip" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtEposta" Name="ekleyen_eposta" PropertyName="Text" />
                    <asp:ControlParameter ControlID="txtAdiSoyadi" Name="ekleyen_adisoyadi" PropertyName="Text" />
                    <asp:QueryStringParameter DefaultValue="0" Name="bilgiler_id" QueryStringField="id" />
                </InsertParameters>
                <SelectParameters>
                    <asp:QueryStringParameter QueryStringField="id" DefaultValue="0" Name="bilgiler_id" Type="Int32"></asp:QueryStringParameter>
                    <asp:Parameter DefaultValue="True" Name="onaylandi" Type="Boolean"></asp:Parameter>
                    <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource runat="server" ID="sdsSeciliBilgiler" ConnectionString='<%$ ConnectionStrings:KisiselWebSitesiConnectionString %>' SelectCommand="SELECT * FROM [Bilgiler] WHERE (([aktif] = @aktif) AND ([silindi] = @silindi)and bilgiler_id = @bilgiler_id) ORDER BY [sira]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="True" Name="aktif" Type="Boolean"></asp:Parameter>
                    <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>
                    <asp:QueryStringParameter DefaultValue="0" Name="bilgiler_id" QueryStringField="id" />
                </SelectParameters>
            </asp:SqlDataSource>

            </ul>
                    <a href="Bilgiler.aspx">Geri</a>
            </asp:Panel>
        </div>

   
    </section>
</asp:Content>
