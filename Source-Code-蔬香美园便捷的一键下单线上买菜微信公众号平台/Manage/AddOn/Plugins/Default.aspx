<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ZoomLaCMS.Manage.AddOn.Plugins.Default" MasterPageFile="~/Manage/I/Index.Master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>插件管理</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("/{manage}/Config/SiteInfo.aspx","系统设置"),	
        new Bread() {url="/{manage}/Addon/Plugins/Default.aspx", text="插件信息",addon="" }}
		)
    %>
<div class="container-fluid pr-0">
<div class="row sysRow list_choice">
<table class="table table-bordered table-striped">
<tr>
    <td class=""></td>
    <td class="">名称</td>
    <td class="">标识</td>
    <td>访问路径</td>
    <td>功能</td>
    <td class="">状态</td>
    <td class="">操作</td>
</tr>
<asp:Repeater runat="server" ID="RPT" OnItemCommand="RPT_ItemCommand">
    <ItemTemplate>
        <tr>
            <td><%#Container.ItemIndex+1 %></td>
            <td><%#Eval("name") %></td>
            <td><%#Eval("symbol") %></td>
            <td><a href="<%#Eval("url") %>" target="_blank">浏览</a></td>
            <td><%#Eval("desc") %></td>
            <td><%#GetState() %></td>
            <td>
                <asp:LinkButton runat="server" CommandName="start" CommandArgument='<%#Eval("symbol") %>' Visible='<%#!Eval("state","").Equals("Active") %>' class="btn btn-xs btn-info">
                    <i class="fa fa-cog"></i>启动</asp:LinkButton>
                <asp:LinkButton runat="server" CommandName="stop" CommandArgument='<%#Eval("symbol") %>' Visible='<%#Eval("state","").Equals("Active") %>' class="btn btn-xs btn-warning">
                    <i class="fa fa-ban"></i>停用</asp:LinkButton>
            </td>
        </tr>
    </ItemTemplate>
</asp:Repeater>
</table>
</div></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">

</asp:Content>