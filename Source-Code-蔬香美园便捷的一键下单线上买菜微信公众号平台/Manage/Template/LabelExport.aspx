﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LabelExport.aspx.cs" Inherits="ZoomLaCMS.Manage.Template.LabelExport" MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>标签升级</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<%=Call.SetBread(new Bread[] {
        new Bread("/{manage}/I/Main.aspx","工作台"),
		new Bread("/{manage}/Config/SiteOption.aspx","系统设置"),
        new Bread("LabelManage.aspx","标签管理"),
        new Bread() {url="", text="标签升级",addon="" }},
		Call.GetHelp(21)
		)
    %>
	<div class="list_choice">
    <div class="card">
        <div class="card-header"><i class="fa fa-flag"> 标签升级</i></div>
        <div class="card-body">
            <div>升级标签：</div>
            <div>升级状态：<span style="color: Red"><asp:Label ID="Remind_L" runat="server"></asp:Label></span></div>
        </div>
        <div class="card-footer">
            <asp:Button ID="OldVerUP_Btn" runat="server" class="btn btn-outline-info" Text="早期标签升级" OnClick="Button1_Click" />
            <asp:Button ID="GlobalUP_Btn" runat="server" class="btn btn-outline-info" Text="国际版标签升级" OnClick="GlobalUP_Btn_Click" />
        </div>
    </div>
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
</asp:Content>
