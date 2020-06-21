<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Optimization.aspx.cs" Inherits="ZoomLaCMS.Manage.Config.Optimization" MasterPageFile="~/Manage/I/Index.master"%>

<%@ Register Src="~/Manage/I/ASCX/SPwd.ascx" TagPrefix="uc1" TagName="SPwd" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <link type="text/css" href="/dist/css/bootstrap-switch.min.css"  rel="stylesheet"/>
    <script type="text/javascript" src="/dist/js/bootstrap-switch.js"></script>
    <title>数据库优化</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("DatalistProfile.aspx","扩展功能"),
        new Bread("","开发中心"),
        new Bread() {url="Optimization.aspx", text="数据库优化",addon="" }}
		)
    %>
<div class="list_choice">
    <uc1:SPwd runat="server" ID="SPwd" Visible="false" />
    <div id="maindiv" runat="server" visible="false">
        <table class="table table-striped table-bordered sys_table">
            <tr>
                <th class="w12rem_lg">请选择表</th>
                <td>
                    <asp:DropDownList ID="DbTableDownList" runat="server" AutoPostBack="True" CssClass="form-control max20rem" OnSelectedIndexChanged="DbTableDownList_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>是否创建唯一索引</th>
                <td>
                    <input runat="server" type="checkbox" id="IsUnique" class="switchChk" />
                </td>
            </tr>
            <tr>
                <th>创建索引的类型</th>
                <td>
                    <asp:DropDownList runat="server" CssClass="form-control max20rem" ID="IndexType">
                        <asp:ListItem Value="">非聚簇索引</asp:ListItem>
                        <asp:ListItem Value="clustered">聚集索引</asp:ListItem>
                        <asp:ListItem Value="nonclustered">非聚集索引</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <th>请输入索引名称</th>
                <td>
                    <input type="text" id="IndexName" class="form-control max20rem" runat="server" value="Zoomla_index" /></td>
            </tr>
            <tr>
                <th>创建索引的字段</th>
                <td>
                    <asp:ListBox ID="DbFieldDownList" runat="server" CssClass="form-control max20rem"  SelectionMode="Multiple" /></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="CreateIndex" Text="创建索引" CssClass="btn btn-outline-info mb-2" runat="server" OnClick="CreateIndex_Click" />
                    <asp:Button ID="ViewIndex" Text="查看已有的索引" CssClass="btn btn-outline-info mb-2" runat="server" OnClick="ViewIndex_Click" />
                </td>
            </tr>
        </table>
        <br />
        <div id="Top" runat="server" visible="false">
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </div>
        <br />
        <div id="RunOK" runat="server">
        </div>
    </div>
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/js/Common.js"></script>
</asp:Content>