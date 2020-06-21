<%@ Page Language="C#"  MasterPageFile="~/Manage/I/Index.master" AutoEventWireup="true" CodeBehind="Projects.aspx.cs" Inherits="ZoomLaCMS.Manage.AddOn.Project.Projects" %>
<asp:Content ContentPlaceHolderID="head" runat="Server"><title><%=lang.LF("查看项目")%></title></asp:Content>
<asp:Content ContentPlaceHolderID="Content" runat="Server">
	<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread() {url="", text="项目管理<a href='AddProjects.aspx'>[新增项目]</a>",addon="" }},
		Call.GetHelp(42)
		)
    %>
	<div class="list_choice">
    <div class="top_opbar">
		<div class="input-group d-flex flex-row">
         <asp:DropDownList ID="SkeyType_DP" CssClass="form-control max20rem inputgp" runat="server">
			<asp:ListItem Value="1" Selected="True">项目名称</asp:ListItem>
			<asp:ListItem Value="2">项目经理</asp:ListItem>
			<asp:ListItem Value="3">技术负责人</asp:ListItem>
		</asp:DropDownList>
        <span class="input-group-append">
            <asp:TextBox ID="Skey_T" runat="server" class="form-control max20rem inputgp" placeholder="关键字" />
			   <asp:TextBox runat="server" ID="STime_T" class="form-control max20rem inputgp" onclick="WdatePicker();" type="text" placeholder="开始时间" />
			  <asp:TextBox runat="server" ID="ETime_T" class="form-control max20rem" onclick="WdatePicker();" type="text" placeholder="结束时间" />
			  <asp:Button ID="BntSearch" runat="server" Text="查询" OnClick="BntSearch_Click" class="btn btn-outline-secondary" />
        </span>
    </div>
    <div class="divbox" id="nocontent" runat="server" style="display: none">
        <%=lang.LF("暂无项目信息")%>
    </div>
    <ul class="nav nav-tabs">
        <li class="nav-item" id="tab0"><a class="nav-link" href="Projects.aspx"><%=lang.LF("所有")%></a></li>
        <li class="nav-item" id="tab0"><a class="nav-link" onclick="ShowTabss(0,0)"><%=lang.LF("未审核")%></a></li>
        <li class="nav-item" id="tab1"><a class="nav-link" onclick="ShowTabss(1,0)"><%=lang.LF("已审核")%></a></li>
        <li class="nav-item" id="tab2"><a class="nav-link" onclick="ShowTabss(2,0)"><%=lang.LF("未启动")%></a></li>
        <li class="nav-item" id="tab3"><a class="nav-link" onclick="ShowTabss(3,0)"><%=lang.LF("已启动")%></a></li>
        <li class="nav-item" id="tab4"><a class="nav-link" onclick="ShowTabss(4,0)"><%=lang.LF("已完成")%></a></li>
        <li class="nav-item" id="tab5"><a class="nav-link" onclick="ShowTabss(5,0)"><%=lang.LF("存档")%></a></li>
    </ul>
	<div class="table-responsive">
    <ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" IsHoldState="false" OnRowDataBound="EGV_RowDataBound"
        OnPageIndexChanging="EGV_PageIndexChanging" AllowPaging="True" AllowSorting="True" OnRowCommand="EGV_RowCommand" DataKeyNames="ID"
        CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True" EmptyDataText="无相关信息！">
        <Columns>
            <asp:TemplateField HeaderText="选择" >
                <ItemTemplate>
                    <input type="checkbox" name="idchk" value="<%# Eval("ID") %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="ID" HeaderText="ID" />
            <asp:TemplateField HeaderText="项目名称" >
                <ItemTemplate>
                    <a href="ProjectsDetail.aspx?ProjectID=<%# Eval("ID","{0}")%>">
                        <%# Eval("ProName")%></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="项目类型" >
                <ItemTemplate>
                    <a href="Projects.aspx?type=<%#Eval("ZType") %>&skey=<%:Skey%>&mystatus=<%:Status %>">
                        <%# GetProType(Eval("ZType","{0}")) %></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="项目价格" >
                <ItemTemplate>
                    <%#Eval("ProPrice", "￥{0}.00")%>
                </ItemTemplate>
            </asp:TemplateField>
            <%--            <asp:TemplateField HeaderText="启动时间" >
                <ItemTemplate>
                    <%#Eval("CDate", "yyyy-MM-dd")%>
                </ItemTemplate>
            </asp:TemplateField>--%>
            <asp:TemplateField HeaderText="项目经理" >
                <ItemTemplate>
                    <%#GetManageer(Eval("ProManageer","{0}"))%></a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="审核" >
                <ItemTemplate>
                    <%# GetAudit(Eval("ZStatus","{0}"))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="项目管理" >
                <ItemTemplate>
                    <%# GetProStatus(Eval("ZStatus", "{0}"))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="当前进度" >
                <ItemTemplate>
                    <a href='<%#Eval("ID","ProjectsProcesses.aspx?ID={0}") %>'>
                        <div style="width: 90%; border: solid 1px green; height: 5px">
                            <div id="line" runat="server" style="background-color: #bddb52; height: 5px; float: left">
                            </div>
                        </div>
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="申请时间" >
                <ItemTemplate>
                    <%#Eval("CDate")%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument='<%# Eval("ID")%>'
                        CommandName="manage" ><i class="fa fa-pencil" title="修改"></i></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument='<%# Eval("ID")%>'
                        CommandName="del" OnClientClick="if(!this.disabled) return confirm('确实要删除吗？');" ><i class="fa fa-trash-o" title="删除"></i></asp:LinkButton>
                    <asp:LinkButton ID="LbtnComments" runat="server" CommandArgument='<%# Eval("ID")%>'
                        CommandName="Comments" ><i class="fa fa-comments" title="评论"></i></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton4" runat="server" CommandArgument='<%# Eval("ID")%>'
                        CommandName="Run" ><i class="fa fa-play-circle"></i><%#Eval("ZStatus", "{0}") != "0"&& Eval("ZStatus", "{0}") != "1" ? "启动" : "停止"%></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("ID")%>'
                        CommandName="Audit" ><i class="fa fa-check-square-o"></i><%#Eval("ZStatus", "{0}") == "0" ? "<font color=green>通过审核</font>" : "<font color=red>取消审核</font>"%></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>
	</div>
	<div class="alert alert-light">
    <asp:Button runat="server" ID="BatDel_Btn" CssClass="btn btn-outline-danger" Text="批量删除" OnClick="BatDel_Btn_Click" OnClientClick="return confirm('确定要删除所选内容吗?');" /></div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script src="/JS/DatePicker/WdatePicker.js"></script>
    <script>
        $(function () {
            $("#tab<%:MyStatus%>").find("a").addClass("active");
        })
        function getinfo(id) {
            location.href = "ProjectsDetail.aspx?ProjectID=" + id + "";
        }
        function fun(SkeyType_DP, Skey_T) {
            location.href = "Projects.aspx?SkeyType_DP=" + SkeyType_DP + "&Skey_T=" + Skey_T;
        }
        function ShowTabss(status, orderby) {
            location = "Projects.aspx?type=<%:SkeyType_DP.SelectedValue%>&skey=<%:Skey%>&mystatus=" + status;
        }

        HideColumn("6,7,8,9,10");
    </script>
</asp:Content>
