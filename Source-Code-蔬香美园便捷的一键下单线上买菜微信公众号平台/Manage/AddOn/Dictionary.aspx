<%@ Page Language="C#" MasterPageFile="~/Manage/I/Index.master" AutoEventWireup="true" CodeBehind="Dictionary.aspx.cs" Inherits="ZoomLaCMS.Manage.AddOn.Dictionary" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>数据字典项目列表</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("/{manage}/plus/ADManage.aspx","扩展功能"),	
        new Bread("DictionaryManage.aspx","数据字典"),	
        new Bread() {url="", text="地区选择",addon="" }}
		)
    %>
    <ZL:ExGridView ID="Egv" runat="server" AutoGenerateColumns="False" DataKeyNames="DicID" PageSize="10"   OnPageIndexChanging="Egv_PageIndexChanging" IsHoldState="false" OnRowCommand="Egv_RowCommand" AllowPaging="True" AllowSorting="True" CssClass="table table-striped table-bordered table-hover list_choice" EnableTheming="False" EnableModelValidation="True" EmptyDataText="无相关数据">
        <Columns>
            <asp:TemplateField HeaderText="选中">
                <ItemTemplate>
                    <input type="checkbox" name="idchk" value='<%#Eval("DicID") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" />
                <HeaderStyle  />
            </asp:TemplateField>
            <asp:BoundField DataField="DicID" HeaderText="序号">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle  />
            </asp:BoundField>
            <asp:TemplateField HeaderText="字典项目">
                <ItemTemplate>
                    <%# Eval("DicName")%>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Left" />
                <HeaderStyle  />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="是否启用">
                <ItemTemplate>
                    <%# GetUsedFlag(Eval("IsUsed","{0}")) %>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle/>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="操作">
                <HeaderStyle/>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Edit1" CommandArgument='<%# Eval("DicID") %>'>修改</asp:LinkButton>
                    | 
                <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Del" CommandArgument='<%# Eval("DicID") %>' OnClientClick="return confirm('确实要删除吗？');">删除</asp:LinkButton>
                    | 
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>
    <table class="table table-striped table-bordered table-hover TableWrap" border="0" cellpadding="0" cellspacing="0" width="100%" id="sleall">
        <tr>
            <td>
                <asp:Button ID="btndelete" runat="server" OnClientClick="if(!IsSelectedId()){alert('请选择删除项');return false;}else{return confirm('你确定要将所有选择项删除吗？')}" Text="批量删除" OnClick="btndelete_Click" class="btn btn-outline-danger mb-2" />
                <asp:Button ID="btnSetUsed" runat="server" Text="批量启用" OnClick="btnSetUsed_Click" class="btn btn-outline-info mb-2" />
                <asp:Button ID="btnSetUnUsed" runat="server" Text="批量停用" OnClick="btnSetUnUsed_Click" class="btn btn-outline-danger mb-2" />
                <asp:Button ID="btnSetAllUsed" runat="server" Text="全部启用" OnClick="btnSetAllUsed_Click" class="btn btn-outline-info mb-2" />
                <asp:HiddenField ID="HdnDicCateID" runat="server" />
            </td>
			<tb class="d-flex flex-row mb-2">
                <span class="ml-2">字典项目名：</span><asp:TextBox ID="txtDicName" runat="server" class="form-control max20rem" data-enter="1"></asp:TextBox>
                <asp:HiddenField ID="HdnDicID" Value="0" runat="server" />
                <asp:Button ID="btnSave" runat="server" Text="添加" OnClick="btnSave_Click" class="btn btn-outline-info ml-2" data-enter="2" />
			</tb>
        </tr>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
        <script src="/JS/Controls/Control.js"></script>
    <script>
        function IsSelectedId() {
            var checkArr = $("input[type=checkbox][name=idchk]:checked");
            if (checkArr.length > 0)
                return true
            else
                return false;
        }
        Control.EnableEnter();
    </script>
</asp:Content>
