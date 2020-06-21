<%@ Page Language="C#" MasterPageFile="~/Manage/I/Index.master" AutoEventWireup="true" CodeBehind="ProjectsAddType.aspx.cs" Inherits="ZoomLaCMS.Manage.AddOn.Project.ProjectsAddType" %>
<asp:Content ContentPlaceHolderID="head" runat="Server"><title>添加项目类型</title></asp:Content>
<asp:Content ContentPlaceHolderID="Content" runat="Server">
	<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("Projects.aspx","项目管理"),
        new Bread("ProjectsType.aspx","分类管理"),
        new Bread() {url="", text="添加类型",addon="" }}
		)
    %>
<div class="container-fluid pr-0">
<div class="row sysRow list_choice">
<table class="table table-striped table-bordered table-hover sys_table">
	<tr>
		<td align="center" colspan="2">
			<asp:Label ID="lblText" runat="server">添加项目类型</asp:Label>
		</td>
	</tr>
	<tr>
		<th class="w12rem_lg">项目类别名</th>
		<td>
			<ZL:TextBox ID="TxtProjectName" class="form-control max20rem" AllowEmpty="false" runat="server" />
		</td>
	</tr>
	<tr>
		<th>项目类别名称简介</th>
		<td>
			<asp:TextBox ID="TxtTypeInfo" class="form-control max20rem" runat="server"  TextMode="MultiLine" />
		</td>
	</tr>
	<tr>
		<td colspan="2" class="text-center">
			<asp:Button ID="Commit_B" runat="server" Text="提交" class="btn btn-info" OnClick="Commit_B_Click" />
			<asp:Button ID="Return_B" runat="server" Text="返回" class="btn btn-outline-info" OnClick="Return_B_Click" />
		</td>
	</tr>
</table>
</div></div>
</asp:Content>