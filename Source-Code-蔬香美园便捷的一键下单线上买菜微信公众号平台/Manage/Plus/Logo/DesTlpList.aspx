﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DesTlpList.aspx.cs" Inherits="ZoomLaCMS.Manage.Plus.Logo.DesTlpList" MasterPageFile="~/Manage/I/Index.Master"%>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>名片模板</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="BreadDiv" class="container-fluid mysite">
        <div class="row">
            <ol id="BreadNav" class="breadcrumb navbar-fixed-top w-100">
                <li class="breadcrumb-item"><a href='<%=CustomerPageAction.customPath2 %>Main.aspx'>工作台</a></li>
                <li class="breadcrumb-item"><a href='IconList.aspx'>图标列表</a></li>
                <li class="breadcrumb-item"><a href='<%=Request.RawUrl %>'>名片模板</a>  [<a href="Design.aspx"><i class="fa fa-pencil"></i>创建模板</a>]</li>
                <div id="help" class="pull-right text-center"><a href="javascript:;" id="sel_btn" class="help_btn" onclick="selbox.toggle();"><i class="fa fa-search"></i></a></div>
                <div id="sel_box" class="padding5">
                    <div class="input-group">
                        <input type="text" id="skey" runat="server" class="form-control mvcparam max20rem" placeholder="请输入关键词" onkeypress="selbox.search();" />
                        <span class="input-group-btn">
                            <asp:LinkButton runat="server" class="btn btn-outline-secondary" ID="Search_Btn" OnClick="Search_Btn_Click"><i class="fa fa-search"></i></asp:LinkButton>
                        </span>
                    </div>
                </div>
            </ol>
        </div>
    </div>
<ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" IsHoldState="false" 
    OnPageIndexChanging="EGV_PageIndexChanging" AllowPaging="True" AllowSorting="True" OnRowCommand="EGV_RowCommand" OnRowDataBound="EGV_RowDataBound"
    CssClass="table table-striped table-bordered" EnableTheming="False" EnableModelValidation="True" EmptyDataText="数据为空">
    <Columns>
        <asp:TemplateField ItemStyle-CssClass="">
            <ItemTemplate>
                <input type="checkbox" name="idchk" value="<%#Eval("ID") %>" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="" />
        <asp:BoundField HeaderText="别名" DataField="Alias" ItemStyle-CssClass=""/>
        <asp:TemplateField HeaderText="预览">
            <ItemTemplate>
                <img src="<%#Eval("PreviewImg") %>" style="width:150px;height:100px;"/>
            </ItemTemplate>
        </asp:TemplateField>
<%--        <asp:TemplateField HeaderText="创建人">
            <ItemTemplate>
                <a href="javascript:;" onclick="user.showuinfo('<%#Eval("UserID") %>');"><%#Eval("UserName") %></a>
            </ItemTemplate>
        </asp:TemplateField>--%>
        <asp:BoundField DataField="CDate"  HeaderText="创建时间" ItemStyle-CssClass=""/>
        <asp:TemplateField HeaderText="操作" ItemStyle-CssClass="">
            <ItemTemplate>
<%--                <a href="/Plugins/Third/Logo/Third.aspx?id=<%#Eval("ID") %>&mode=admin" title="预览" target="_blank"><i class="fa fa-eye"></i></a>--%>
                <a href="Design.aspx?ID=<%#Eval("ID") %>"><i class="fa fa-pencil"></i></a>
                <asp:LinkButton runat="server" CommandName="del2" CommandArgument='<%#Eval("ID") %>' OnClientClick="return confirm('确定要删除吗');"><i class="fa fa-trash-o" title="删除"></i></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</ZL:ExGridView>
<div class="alert alert-light">
    <asp:Button runat="server" ID="BatDel_Btn" Text="批量删除" OnClick="BatDel_Btn_Click" class="btn btn-outline-danger"/>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script>
    function showDesign(id) {
        ShowComDiag("/Plugins/Third/Logo/Third.aspx?id="+id+"&mode=admin", "查看设计");
    }
</script>
</asp:Content>