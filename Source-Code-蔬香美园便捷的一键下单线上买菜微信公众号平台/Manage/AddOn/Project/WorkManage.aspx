<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkManage.aspx.cs" Inherits="ZoomLaCMS.Manage.AddOn.Project.WorkManage" MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content ContentPlaceHolderID="head" runat="Server"><title>项目工作内容列表</title></asp:Content>
<asp:Content ContentPlaceHolderID="Content" runat="Server">
<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("Projects.aspx","项目管理"),
        new Bread() {url="", text="流程管理<a href='AddWork.aspx'>[添加流程]</a>",addon="" }},
		Call.GetHelp(43)
		)
    %>
    <asp:Label ID="LblProject" runat="server" Text=""></asp:Label>
    <ZL:ExGridView ID="EGV" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="table table-striped table-bordered list_choice"
         DataKeyNames="ID" PageSize="10" OnPageIndexChanging="Egv_PageIndexChanging" OnRowCommand="EGV_RowCommand" EmptyDataText="无任何相关数据" OnRowDataBound="Egv_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="选择" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <input type="checkbox" name="idchk" value="<%#Eval("ID") %>" />
                </ItemTemplate>
                <HeaderStyle  />
            </asp:TemplateField>
            <asp:BoundField DataField="ID" HeaderText="ID" ItemStyle-HorizontalAlign="Center">
                <HeaderStyle  />
            </asp:BoundField>
            <asp:TemplateField HeaderText="流程名称">
                <ItemTemplate>
                    <a href="AddWork.aspx?id=<%#Eval("ID")%>">
                        <%#DataBinder.Eval(Container.DataItem, "WorkName").ToString()%></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="启用" ItemStyle-HorizontalAlign="Center" >
                <ItemTemplate>
                    <%# (int)Eval("Status") == 0 ? "<span class=\"text-danger\">×</span>" : "<font color=green>√</font>"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="批准" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <%# (int)Eval("Approving") == 0 ? "<span class=\"text-danger\">×</span>" : "<font color=green>√</font>"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="操作" >
                <ItemTemplate>
                    <asp:HiddenField ID="hfid" runat="server" Value='<%#Eval("ID") %>' />
                    <asp:LinkButton ID="LinkButton2" runat="server" CommandName="EditWork" CommandArgument='<%# Eval("ID")%>' ><i class="fa fa-pencil" title="修改"></i></asp:LinkButton>
                    <asp:LinkButton ID="LnkDelete" runat="server" CommandName="DelWork"  CommandArgument='<%# Eval("ID")%>' OnClientClick="return confirm('确实要删除吗？');" ><i class="fa fa-trash-o" title="删除"></i></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="FinishWork" CommandArgument='<%# Eval("ID")%>' OnClientClick="return confirm('确实要执行此操作吗？');" ><i class="fa fa-play-circle"></i><%# (int)Eval("Status") == 0 ? "启用":"停用"%></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>    
        </Columns>
    </ZL:ExGridView>
	<div class="alert alert-light">
    <asp:Button ID="btnDel" runat="server" Text="批量删除" OnClick="btnDel_Click" OnClientClick="return confirm('确定要删除吗');" class="btn btn-outline-danger" />
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
</asp:Content>
