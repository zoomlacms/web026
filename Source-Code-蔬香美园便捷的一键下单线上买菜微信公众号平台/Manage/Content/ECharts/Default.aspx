﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ZoomLaCMS.Manage.Content.ECharts.Default" MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>图表列表</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("Default.aspx","智慧图表"),
        new Bread() {url="Default.aspx", text="图表列表<a href='AddChart.aspx'>[创建图表]</a>",addon="" }}
		)
    %>
    <ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" OnRowCommand="EGV_RowCommand"
        OnPageIndexChanging="Egv_PageIndexChanging" IsHoldState="false" AllowPaging="True" AllowSorting="True"
        CssClass="table table-striped table-bordered list_choice" EnableTheming="False" EnableModelValidation="True" EmptyDataText="没有内容">
        <Columns> 
            <asp:TemplateField ItemStyle-CssClass="">
                <ItemTemplate>
                    <input type="checkbox" name="idchk" value="<%#Eval("ID") %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass=""/>
            <asp:TemplateField HeaderText="图表名称">
                <ItemTemplate>                
                        <a class="edit_a" href="/Plugins/ECharts/ShowM.aspx?ID=<%#Eval("ID") %>" target="_blank"><%#Eval("TName") %></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="图表类型">
                <ItemTemplate>
                    <a href="?stype=<%#Eval("SType") %>" title="点击创建"> <%# GetStype() %></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CDate" DataFormatString="{0:yyyy年MM月dd日}" HeaderText="创建时间" />    
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                   <a href="/Plugins/ECharts/ShowM.aspx?ID=<%#Eval("ID") %>" target="_blank" title="预览"><span class="fa fa-eye" title="预览"></span></a>
                    <a href="AddChart2.aspx?<%#"id="+Eval("ID")+"&type="+Eval("SType")+"&tag="+Eval("Tag") %>" ><span class="fa fa-pencil" title="编辑"></span> </a>
                    <asp:LinkButton runat="server" CommandArgument='<%#Eval("ID") %>'  CommandName="del2" OnClientClick="return confirm('确定要删除吗?');"><span class="fa fa-trash" title="删除"></span> </asp:LinkButton>
                    <a href="ChartCite.aspx?ID=<%#Eval("ID") %>"  title="引用"><span class="fa fa-share-alt"></span> 引用</a>
                </ItemTemplate>
            </asp:TemplateField>         
        </Columns>
    </ZL:ExGridView>
	<div class="alert alert-light">
    <asp:Button id="Dels_B" runat="server" CssClass="btn btn-outline-danger" Text="批量删除" OnClick="Dels_B_Click" OnClientClick="return confirm('确定要删除吗?');" /></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script>
    $().ready(function () {
        $(".option_area").click(function(e) {
			if($(this).find(".option_box_hid").length>0){
				$(".option_box").addClass("option_box_hid");
				$(this).find(".option_box").removeClass("option_box_hid");	
			}
			else{ 
				$(this).find(".option_box").addClass("option_box_hid");
			}	 
        });
        $("#EGV tr").dblclick(function () {
            if ($(this).find(".edit_a")[0]) {
                location.href = $(this).find(".edit_a").attr("href");
            }
        });
    });
</script>
</asp:Content>