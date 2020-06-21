﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddQuestionRecord.aspx.cs" Inherits="ZoomLaCMS.Manage.iServer.AddQuestionRecord" ValidateRequest="false" MasterPageFile="~/Manage/I/Index.master"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>添加问题</title>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.min.js"></script>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("BiServer.aspx","有问必答"),
        new Bread() {url="AddQuestionRecord.aspx", text="添加问题记录",addon="" }},
		Call.GetHelp(50)
		)
    %>
    <asp:HiddenField runat="server" ID="OrderID" />
	<div class="container-fluid pr-0">
	<div class="row sysRow list_choice table-responsive">
    <table class="table table-striped table-bordered sys_table">
        <tr>
            <th class="w12rem_lg">会员登录帐号<span class="text-danger">*</span>
            </th>
            <td>
                <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control max20rem" Text=""></asp:TextBox>
            </td>
        </tr>
        <tr>
            <th >状态<span class="text-danger">*</span>
            </th>
            <td>
                <asp:DropDownList ID="DropDownList1" CssClass="form-control max20rem" runat="server" AutoPostBack="true">
                    <asp:ListItem Selected="True" Value="未解决">未解决</asp:ListItem>
                    <asp:ListItem Value="处理中">处理中</asp:ListItem>
                    <asp:ListItem Value="已解决">已解决</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <th >优先级<span class="text-danger">*</span>
            </th>
            <td>
                <asp:RadioButtonList ID="Priority_RBL" runat="server" RepeatDirection="Horizontal" >
                    <asp:ListItem Value="低">低</asp:ListItem>
                    <asp:ListItem Value="中" Selected="True">中</asp:ListItem>
                    <asp:ListItem Value="高">高</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <th>提交来源<span class="text-danger">*</span></th>
            <td class="d-flex flex-row">
                <asp:DropDownList ID="DropDownList3" CssClass="form-control max20rem" runat="server">
                    <asp:ListItem Selected="True" Value="电话">电话</asp:ListItem>
                    <asp:ListItem Value="E-mai">E-mail</asp:ListItem>
                    <asp:ListItem Value="网页表单">网页表单</asp:ListItem>
                    <asp:ListItem Value="直接面谈">直接面谈</asp:ListItem>
                    <asp:ListItem Value="其它">其它</asp:ListItem>
                </asp:DropDownList>
                输入电话号码、E-mail等：<asp:TextBox ID="txtRootInfo" CssClass="form-control text_md" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <th >问题类别<span class="text-danger">*</span>
            </th>
            <td>
                <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-control max20rem">                    
                    <asp:ListItem Selected="True" Value="咨询">咨询</asp:ListItem>
                    <asp:ListItem Value="投诉">投诉</asp:ListItem>
                    <asp:ListItem Value="建议">建议</asp:ListItem>
                    <asp:ListItem Value="要求">要求</asp:ListItem>
                    <asp:ListItem Value="界面使用">界面使用</asp:ListItem>
                    <asp:ListItem Value="bug报告">bug报告</asp:ListItem>
                    <asp:ListItem Value="订单">订单</asp:ListItem>
                    <asp:ListItem Value="财务">财务</asp:ListItem>
                    <asp:ListItem Value="域名">域名</asp:ListItem>
                    <asp:ListItem Value="主机">主机</asp:ListItem>
                    <asp:ListItem Value="邮局">邮局</asp:ListItem>
                    <asp:ListItem Value="DNS">DNS</asp:ListItem>
                    <asp:ListItem Value="MSSQL">MSSQL</asp:ListItem>
                    <asp:ListItem Value="MySQL">MySQL</asp:ListItem>
                    <asp:ListItem Value="IDC">IDC</asp:ListItem>
                    <asp:ListItem Value="网站推广">网站推广</asp:ListItem>
                    <asp:ListItem Value="网站制作">网站制作</asp:ListItem>
                    <asp:ListItem Value="其它">其它</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <th >问题标题<span class="text-danger">*</span>
            </th>
            <td>
                <ZL:TextBox ID="txtTitle" runat="server" CssClass="form-control max20rem" AllowEmpty="false"></ZL:TextBox>
            </td>
        </tr>
        <tr>
            <th >问题内容<span class="text-danger">*</span>
            </th>
            <td>
                <ZL:TextBox ID="Content_T" runat="server" class="m50rem_50"  AllowEmpty="false" height=400 TextMode="MultiLine"></ZL:TextBox>
            </td>
        </tr>
        <tr>
            <th >附注（内部使用）</th>
            <td>
                <asp:TextBox ID="Remind_L" runat="server" CssClass="form-control m50rem_50" Rows="6" TextMode="MultiLine"></asp:TextBox> 
            </td>
        </tr>
        <tr>
            <th>附件</th>
            <td>
               <input type="button" id="upfile_btn" class="btn btn-outline-info" value="选择文件" />
                 <div class="mt-3" id="uploader" class="uploader"><ul class="filelist"></ul></div>
                 <asp:HiddenField runat="server" ID="Attach_Hid" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-info" runat="server" OnClientClick="setcontent();" OnClick="LinkButton1_Click">添加</asp:LinkButton>
                <a href="BiServer.aspx" class="btn btn-outline-info">返回列表</a>
            </td>
        </tr>
    </table>
	</div></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/js/Common.js"></script>
    <script type="text/javascript" src="/js/zh-CN/attachment.js"></script>
    <script type="text/javascript" src="/JS/Controls/ZL_Dialog.js"></script>
    <script src="/JS/Controls/ZL_Webup.js"></script>
<link href="/JS/Controls/ZL_Webup.css" rel="stylesheet" />
   <%= Call.GetUEditor("Content_T")%>
    <script>
        $(function () {
            ZL_Webup.config.json.accept = 'img';
            $("#upfile_btn").click(ZL_Webup.ShowFileUP);
        })
        function AddAttach(file, ret, pval) { return ZL_Webup.AddAttach(file, ret, pval); }
        function fn_CheckLoginSearch(theForm) {
            if (!fn_CheckRequired(theForm.login, "登录帐号"))
                return false;
            return true;
        }
        function fn_CheckSupportTicket(theForm) {
            if (theForm.source_type.options[theForm.source_type.selectedIndex].value == 'phone'
			  || theForm.source_type.options[theForm.source_type.selectedIndex].value == 'email') {
                if (!fn_CheckRequired(theForm.source, "电话或者E-mail"))
                    return false;
            }
            if (!fn_CheckRequired(theForm.title, "问题标题"))
                return false;
            if (!fn_CheckRequired(theForm.content, "问题内容"))
                return false;
            return true;
        }
        function setcontent() {
            $("#Content_T").val(UE.getEditor("Content_T").getContent());
        }
    </script>
</asp:Content>
