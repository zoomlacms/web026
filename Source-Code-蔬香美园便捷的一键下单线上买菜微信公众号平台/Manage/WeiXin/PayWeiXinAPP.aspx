<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PayWeiXinAPP.aspx.cs" Inherits="ZoomLaCMS.Manage.WeiXin.PayWeiXinAPP"  MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>微信APP支付配置</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("/{manage}/WeiXin/Home.aspx","移动微信"),				
        new Bread() {url="", text="APP微信支付",addon="" }}
		)
    %>
<div class="container-fluid pr-0">
<div class="row sysRow list_choice">
<table class="table table-bordered table-striped">
    <tr><td class="td_m">APPID</td><td><ZL:TextBox runat="server" ID="APPID_T" CssClass="form-control max20rem" AllowEmpty="false" /></td></tr>
    <tr><td>APPSecret</td><td><ZL:TextBox runat="server" ID="APPSecret_T" CssClass="form-control max20rem" AllowEmpty="false" /></td></tr>
    <tr><td>商户号</td><td><ZL:TextBox runat="server" ID="MCHID_T" CssClass="form-control max20rem" AllowEmpty="false" /></td></tr>
    <tr><td>商户Key</td><td><ZL:TextBox runat="server" ID="Key_T" CssClass="form-control max20rem" AllowEmpty="false" /></td></tr>
    <tr><td></td><td><asp:Button runat="server" ID="Save_Btn" Text="保存信息" OnClick="Save_Btn_Click" CssClass="btn btn-outline-info" /></td></tr>
</table>
</div></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">

</asp:Content>