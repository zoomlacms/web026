﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LabelManage.aspx.cs" Inherits="ZoomLaCMS.Manage.Template.LabelManage"  MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title><%=Resources.L.标签管理 %></title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div id="BreadDiv" class="container-fluid mysite">
<div class="row">
<ol id="BreadNav" class="breadcrumb navbar-fixed-top w-100">
    <li class="breadcrumb-item"><a href="<%=CustomerPageAction.customPath2 %>Main.aspx"><%=Resources.L.工作台 %></a></li>
    <li class="breadcrumb-item"><a href="<%=CustomerPageAction.customPath2 %>Config/SiteOption.aspx"><%=Resources.L.系统设置 %></a></li>
    <li class="breadcrumb-item"><a href="LabelManage.aspx"><%=Resources.L.标签管理 %></a></li>
    <div class="float-left dropdown ml-3">
        <a href="javascript:;" class="btn btn-info dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-plus-circle"></i> <%=Resources.L.添加标签 %></a>
            <ul class="dropdown-menu" role="menu">
                <li><a class="dropdown-item" href="LabelSql.aspx"><i class="fa fa-circle-o"></i> <%=Resources.L.动态标签 %></a></li>
                <li><a class="dropdown-item" href="LabelHtml.aspx"><i class="fa fa-code"></i> <%=Resources.L.静态标签 %></a></li>
                <li><a class="dropdown-item" href="PageLabel.aspx"><i class="fa fa-file-excel-o"></i> <%=Resources.L.分页标签 %></a></li>
				<li><a class="dropdown-item" href="LabelExport.aspx" title="<%=Resources.L.从旧版标签升级 %>"><i class="fa fa-arrow-circle-up"></i> <%=Resources.L.旧版升级 %></a></li>
            </ul> 
    </div>
    <div id="help" class="pull-right text-center"><a href="javascript::" id="sel_btn" class="help_btn mr-2"><i class="fa fa-search"></i></a><a onclick="help_show('21')" title="<%=Resources.L.帮助 %>" class="help_btn"><span class="fa fa-question-circle"></span></a></div>
</ol>
</div>
</div>
<div id="sel_box" class="">
<div class="input-group">
    <asp:TextBox runat="server" ID="TxtLableName" class="form-control" onkeydown="return GetEnterCode('click','HidSearch');" placeholder="<%$Resources:L,检索当前位置 %>" />
    <span class="input-group-btn">
            <asp:LinkButton runat="server" CssClass="btn btn-outline-secondary" ID="Search_Btn" OnClick="BtnSearch_Click"><%=Resources.L.搜索 %></asp:LinkButton>
            <asp:Button runat="server" ID="BtnSearch" OnClick="BtnSearch_Click" style="display:none;" />
    </span>
</div>
</div>
<div id="navtabs_div" class="sysUsertabs">
</div>

<table class="table table-striped table-bordered table-hover">
    <tr class="gridtitle text-center">
        <td class="td_s"><%=Resources.L.选择 %></td>
        <td><%=Resources.L.名称 %></td>
        <td><%=Resources.L.标签分类 %></td>
        <td><%=Resources.L.标签类别 %></td>
        <td><%=Resources.L.操作 %></td>
    </tr>
    <ZL:ExRepeater runat="server" ID="RPT" PageSize="20"  BoxType="dp" PagePre="<tr><td><input type='checkbox' id='chkAll'/></td><td colspan='8'><div class='text-center'>" PageEnd="</div></td></tr>"  OnItemCommand="repFileReName_ItemCommand">
        <ItemTemplate>
            <tr ondblclick="ckl('<%# Eval("LabelName") %>')">
                <td><input type="checkbox" name="idchk" value="<%#Eval("LabelID") %>" /></td>
                <td class="text-left">
                    <%# GetLabelLink(Eval("LabelID",""), Eval("LabelName",""), Eval("LabelType",""),Eval("LabelName",""))%>
                </td>
                <td class="text-center"><a href="LabelManage.aspx?Cate=<%# HttpUtility.UrlEncode(Eval("LabelCate",""))%>"><%#Eval("LabelCate") %></a></td>
                <td class="text-center"><%#GetLabelType(Eval("LabelType").ToString()) %></td>
                <td class="text-center" id="select">
                     <%# GetLabelLink(Eval("LabelID",""), Eval("LabelName",""), Eval("LabelType",""),"<i class='fa fa-pencil' title='"+Resources.L.修改+"'></i>")%>
                    <asp:LinkButton  runat="server" CommandName="Copy" CommandArgument='<%# Eval("LabelName") %>' OnClientClick="return confirm('确实复制此标签?');"><i class="fa fa-copy" title="<%=Resources.L.复制 %>"></i></asp:LinkButton>
                    <asp:LinkButton  runat="server" CommandName="Download" CommandArgument='<%# Eval("LabelName") %>'><i class="fa fa-download" title="下载"></i></asp:LinkButton>
                    <asp:LinkButton  runat="server" CommandName="Del" CommandArgument='<%# Eval("LabelName") %>'  OnClientClick="return confirm('确实删除此标签?');"><i class="fa fa-trash-o" title="<%=Resources.L.删除 %>"></i></asp:LinkButton>
   <%--                 <a  href="../APP/AddJsonP.aspx?LabelID=<%#Eval("LabelID") %>"  title="JsonP<%=Resources.L.跨域调用 %>"><i class="fa fa-list"></i><%=Resources.L.调用 %></a>--%>
                    <a  href="LabelCallTab.aspx?labelName=<%#Eval("LabelName") %>"><i class="fa fa-share-alt"></i><%=Resources.L.引用 %></a>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate><div class="clearfix"></div></FooterTemplate>
    </ZL:ExRepeater>
</table>

<div class="alert alert-light">
<asp:Button ID="Button1" runat="server" Text="<%$Resources:L,批量导出 %>" class="btn btn-outline-info"
    OnClick="btnExport_Click" OnClientClick="return confirm('你确定要导出选中标签吗？')" Visible="false" />
<asp:Button ID="Button3" runat="server" Text="<%$Resources:L,批量导入 %>" Visible="false" OnClientClick="location.href='LabelImport.aspx';return false;" class="btn btn-outline-info"
    UseSubmitBehavior="true" />
<asp:Button ID="Button2" runat="server" Text="<%$Resources:L,批量删除 %>" OnClick="btnDeleteAll_Click" OnClientClick="return confirm('你确定要将所有选择标签删除吗？')" class="btn btn-outline-danger" UseSubmitBehavior="true" />
<asp:HiddenField ID="LabelTypeData_Hid" runat="server" />
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script src="/JS/SelectCheckBox.js"></script>
<script src="/JS/Plugs/ZL_NavTab.js"></script>
<script type="text/javascript">
$(function () {
    $("#chkAll").click(function () {
        selectAllByName(this, "idchk");
    });
    $("#navtabs_div").ZL_NavTab({
        feildid: "name",
        feildname: "label",
        curid: "<%=LabelCate %>",
        hid: "LabelTypeData_Hid",
        tabclick: function (id) {
            location.href = "LabelManage.aspx?cate="+encodeURIComponent(id);
        }
    });
})
function ckl(LabelName) {
    window.location.href = "LabelHtml.aspx?LabelName=" + LabelName;
}
$("#sel_btn").click(function (e) {
    if ($("#sel_box").css("display") == "none") {
        $(this).addClass("active");
        $("#sel_box").slideDown(300);
    }
    else {
        $(this).removeClass("active");
        $("#sel_box").slideUp(200);
    }
});
</script>
</asp:Content>