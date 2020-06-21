﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserExp.aspx.cs" Inherits="ZoomLaCMS.Manage.User.UserExp"  MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>会员<%=GetTypeName() %></title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("/{manage}/User/UserManage.aspx","会员管理"),
        new Bread("UserInfo.aspx?ID="+UserID,"会员信息"),
        new Bread() {url="", text="会员金额操作",addon="" }}
		)
    %>
	<div class="list_choice">
    <div id="UserPDiv" runat="server">
        <table class="table table-striped table-bordered table-hover sys_table">
            <tr class="text-center">
                <td colspan="2"><asp:Label ID="Lbl_t" runat="server" Text="会员积分操作"></asp:Label></td>
            </tr>
            <tr>
                <th class="w12rem_lg">会员名</th>
                <td>
                    <a href="UserInfo.aspx?id=<%:UserID %>"><asp:Label ID="lbUserName" runat="server" Text=""></asp:Label></a>
                </td>
            </tr>
            <tr>
                <th>会员<%=GetTypeName() %></th>
                <td><asp:Label ID="lblExp" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr>
                <th><%=GetTypeName() %>操作</th>
                <td>
                    <asp:RadioButtonList ID="rblExp" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Value="1" Selected="True">增加</asp:ListItem>
                        <asp:ListItem Value="2">扣减</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>

            <tr>
                <th><%=GetTypeName() %></th>
                <td>
                    <asp:TextBox ID="TxtScore" runat="server" class="form-control text_md num" autocomplete="off"></asp:TextBox>
                    <asp:RegularExpressionValidator runat="server" Display="Dynamic" ID="RV2" ValidationExpression="^(\d*\.\d{0,2}|[1-9]+).*$" ControlToValidate="TxtScore" ErrorMessage="只能输入非0整数" ForeColor="Red" />
                    <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="ScoreVa" ControlToValidate="TxtScore" ErrorMessage="不能为空!" ForeColor="Red" />
                </td>
            </tr>
            <tr>
                <th>上传凭证</th>
                <td>
                    <input type="button" id="upfile_btn" class="btn btn-info" value="选择文件" />
                    <div id="uploader" class="uploader mt-2">
                        <ul class="filelist"></ul>
                    </div>
                    <input type="hidden" id="Attach_Hid" name="Attach_Hid" runat="server"/>
                </td>
            </tr>
            <tr>
                <th>备注</th>
                <td>
                    <asp:TextBox ID="TxtDetail" runat="server" TextMode="MultiLine" class="form-control m50rem_50" Height="150"></asp:TextBox></td>
            </tr>
            <tr>
                <th>同时操作会员</th>
                <td>
                    <asp:TextBox ID="SourceMem" runat="server" CssClass="form-control max20rem" /></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="EBtnSubmit" Text="确定" OnClick="EBtnSubmit_Click" runat="server" class="btn btn-outline-info" OnClientClick="disBtn(this,2000);"/>
                    <a href="Userinfo.aspx?id=<%:UserID %>" class="btn btn-outline-info">取消</a>
                </td>
            </tr>
        </table>
        <ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" DataKeyNames="ExpHisID" PageSize="20" OnPageIndexChanging="EGV_PageIndexChanging" IsHoldState="false" OnRowCommand="EGV_RowCommand" AllowPaging="True" AllowSorting="True" CellPadding="2" CellSpacing="1" BackColor="White" ForeColor="Black" CssClass="table table-striped table-bordered table-hover" EnableTheming="False" GridLines="None" EnableModelValidation="True">
            <Columns>
                <asp:BoundField HeaderText="ID" DataField="ExpHisID" HeaderStyle-Height="22" />
                <asp:BoundField HeaderText="操作时间" DataField="HisTime" />
                <asp:BoundField HeaderText="操作金额" DataField="Score" DataFormatString="{0:f2}" />
                <asp:TemplateField HeaderText="凭证">
                    <ItemTemplate>
                        <%#ShowImgs() %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="操作人">
                    <ItemTemplate>
                        <a href='AdminDetail.aspx?roleid=0&id=<%#Eval("Operator") %>' target="_blank"><%#GetUserName(Eval("Operator", "{0}"))%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="详细" DataField="Detail" />
                <asp:TemplateField HeaderText="操作">
                    <ItemTemplate>
                        <a href="UserExp.aspx?UserID=<%=UserID %>&type=<%=ExpType %>&editid=<%#Eval("ExpHisID") %>">修改</a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </ZL:ExGridView>
    </div>
    <table id="EditMoney" class="table table-striped table-bordered table-hover" runat="server" visible="false">
        <tr>
            <td class="text-right td_l">ID：</td>
            <td>
                <asp:Label ID="UserExpDomPID" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td class="text-right">操作时间：</td>
            <td>
                <asp:TextBox ID="HisTime" CssClass="form-control text_md" runat="server" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd HH:mm:ss' });"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="text-right">会员<%=GetTypeName() %>：</td>
            <td>
                <asp:TextBox ID="Score" CssClass="form-control text_md" runat="server" Text="0"></asp:TextBox>
                <asp:RegularExpressionValidator runat="server" ID="RegularExpressionValidator1" ValidationExpression="^(\d*\.\d{0,2}|[1-9]+).*$" Display="Dynamic" ControlToValidate="Score" ErrorMessage="只能输入非0整数" ForeColor="Red" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" ControlToValidate="Score" ErrorMessage="不能为空!" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td class="text-right">详细：</td>
            <td>
                <asp:TextBox ID="Detail" Rows="10" TextMode="MultiLine"  CssClass="form-control m50rem_50" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <asp:Button ID="EditBtn" Text="修改" class="btn btn-primary" OnClick="EditBtn_Click" runat="server" />
                <a href="UserExp.aspx?UserID=<%=UserID %>&type=<%=ExpType %>" class="btn btn-primary">取消</a>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="UserPH" runat="server" />
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<style type="text/css">
    .img_wrap { padding: 5px; display: inline-block; text-decoration: none; }
    .img_wrap img { max-width: 80px; }
</style>
<script type="text/javascript" src="/JS/DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/JS/ZL_Regex.js"></script>
<script>
    $(function () { ZL_Regex.B_Float(".num") });
</script>
<link href="/JS/Controls/ZL_Webup.css" rel="stylesheet" />
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/Controls/ZL_Webup.js"></script>
<script>
    $(function () {
        ZL_Webup.config.json.accept = 'img';
        $("#upfile_btn").click(ZL_Webup.ShowFileUP);
        var imgs = $("#Attach_Hid").val();
        if (imgs != "") { ZL_Webup.AddReadOnlyLi(imgs); }
    })
    function AddAttach(file, ret, pval) { return ZL_Webup.AddAttach(file, ret, pval); }
</script>
<script runat="server">
    public string ShowImgs()
    {
        string html = "";
        string attach = ZoomLa.Common.DataConverter.CStr(Eval("attach"));
        if (string.IsNullOrEmpty(attach)) { return html; }
        foreach (string img in attach.Split('|'))
        {
            if (string.IsNullOrEmpty(img)) { continue; }
            html += "<a class='img_wrap' href='" + img + "' target='_blank' title='点击查看大图'><img src='" + img + "' /></a>";
        }
        return html;
    }
</script>
</asp:Content>
