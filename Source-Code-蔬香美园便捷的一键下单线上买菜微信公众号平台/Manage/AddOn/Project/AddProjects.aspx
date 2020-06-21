<%@ Page Language="C#" MasterPageFile="~/Manage/I/Index.master" AutoEventWireup="true" CodeBehind="AddProjects.aspx.cs" ValidateRequest="false" Inherits="ZoomLaCMS.Manage.AddOn.Project.AddProjects" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
<title>新建项目</title>
    <script type="text/javascript" src="/Plugins/Ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="/Plugins/Ueditor/ueditor.all.min.js"></script>
</asp:Content>
<asp:Content ContentPlaceHolderID="Content" runat="Server">
	<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("Projects.aspx","项目管理"),
        new Bread() {url="", text="新增项目",addon="" }}
		)
    %>
<div class="list_choice">
    <ul class="nav nav-tabs">
        <li class="nav-item"><a class="nav-link active" href="#Tabs0" data-toggle="tab">基本资料</a></li> 
        <li class="nav-item"><a class="nav-link" href="#Tabs1" data-toggle="tab">客户信息</a></li>
        <li class="nav-item"><a class="nav-link" href="#Tabs2" data-toggle="tab">项目需求</a></li>
        <li class="nav-item"><a class="nav-link" href="#Tabs3" data-toggle="tab">流程管理</a></li>
    </ul>
    <div class="tab-content panel-body">
        <div class="tab-pane active" id="Tabs0">
            <table class="table table-striped table-bordered table-hover sys_table">
                <tbody>
                    <tr>
                        <th class="w12rem_lg">
                            <b>名称</b><br />
                            项目的名称<span class="text-danger">*</span>
                        </th>
                        <td>
                            <asp:TextBox ID="TxtProjectName" runat="server" class="form-control max20rem"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RV" runat="server" ControlToValidate="TxtProjectName" Display="Dynamic" ErrorMessage="*" ToolTip="项目名称必须填">项目名称不可为空</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <b>项目类型</b><br />
                            请选择项目类型
                        </th>
                        <td>
                            <asp:DropDownList ID="DDList" runat="server" CssClass="form-control max20rem"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <th class="w12rem_lg">
                            <b>项目价格</b><br />
                            完成此项目的价格<span class="text-danger">*</span>
                        </th>
                        <td>
							<div class="input-group mb-3">
							  <asp:TextBox ID="TxtProjectPrice" runat="server" class="form-control max20rem"></asp:TextBox>
							  <div class="input-group-append">
								<span class="input-group-text"><i class="fa fa-rmb"></i></span>
							  </div>
							</div>
							
                            <asp:RequiredFieldValidator ID="RvPrice" runat="server" ControlToValidate="TxtProjectPrice" CssClass="errclass"
                                Display="Dynamic" ErrorMessage="*">价格不可为空</asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="Rvr" runat="server" ControlToValidate="TxtProjectPrice" CultureInvariantValues="True"
                                Display="Dynamic" ErrorMessage="*" MaximumValue="9999999999999" MinimumValue="1" CssClass="errclass"
                                Type="Double">价格格式不对</asp:RangeValidator>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <b>项目经理</b>
                        </th>
                        <td>
							<div class="input-group mb-3">
							  <asp:TextBox ID="Leader" runat="server" class="form-control max20rem"></asp:TextBox>
							  <%--<asp:HiddenField runat="server" ID="ProManageerID_H" />--%>
							  <div class="input-group-append">
								<input id="Button3" type="button" value="选择负责人" data-toggle="modal" data-target="#userinfo_div" onclick="ShowUserInfo1(); void (0)" class="btn btn-outline-info" />
							  </div>
							</div>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            <b>技术负责人</b>
                        </th>
                        <td>
                            <ZL:TextBox ID="WebCoding" runat="server" AllowEmpty="false" class="form-control max20rem"></ZL:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="tab-pane" id="Tabs1">
            <table class="table table-striped table-bordered table-hover sys_table">
                <tbody>
                            <tr>
                                <th class="w12rem_lg">
                                    <b>姓名</b><br />
                                    申请人姓名<span class="text-danger">*</span>
                                </th>
                                <td>
								<div class="input-group mb-3">
								  <asp:TextBox ID="TxtUserName" runat="server" class="form-control max20rem"></asp:TextBox>
								   <%--<asp:HiddenField runat="server" ID="CustomerID_H" />--%>
								  <div class="input-group-append">
									<input id="Button1" type="button" value="选择用户" data-toggle="modal" data-target="#userinfo_div" onclick="ShowUserInfo(); void (0)" class="btn btn-outline-info" />
								  </div>
								</div>
								<asp:RequiredFieldValidator ID="RvName" runat="server" ControlToValidate="TxtUserName"
								ErrorMessage="姓名不可为空" Display="Dynamic">姓名不可为空</asp:RequiredFieldValidator>
										
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <b>单位</b><br />
                                    申请人的工作单位
                                </th>
                                <td>
                                    <asp:TextBox ID="TxtUserCompany" runat="server" class="form-control max20rem"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <b>联系电话</b><br />
                                    申请人的常用电话
                                </th>
                                <td >
                                    <asp:TextBox ID="TxtUserTel" runat="server" class="form-control max20rem"></asp:TextBox> 
									<small class="text-muted">(输入您的联系电话)</small>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <b>手机</b><br />
                                    申请人的手机号码
                                </th>
                                <td align="left" valign="middle">
                                    <asp:TextBox ID="TxtUserMobile" runat="server"  class="form-control max20rem"></asp:TextBox>
                                    <asp:RangeValidator ID="RvMB" runat="server" ControlToValidate="TxtUserMobile" ErrorMessage="RangeValidator" 
                                        Display="Dynamic" MinimumValue="13000000000" MaximumValue="18999999999">手机号输入不正确</asp:RangeValidator>
									<small class="text-muted">(输入您的11位手机号,方便与您联系)</small>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <b>QQ</b><br />
                                    申请人的QQ号码
                                </th>
                                <td>
                                    <asp:TextBox ID="TxtUserQQ" runat="server" class="form-control max20rem"></asp:TextBox>
                                    <asp:RangeValidator ID="RvQQ" runat="server" ErrorMessage="RangeValidator" ControlToValidate="TxtUserQQ"
                                        Display="Dynamic" MaximumValue="9999999999" MinimumValue="1111" Type="Double">QQ格式不对</asp:RangeValidator>
									<small class="text-muted">(请输入您的QQ号码4位-10位)</small>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <b>MSN</b><br />
                                    申请人MSN号码
                                </th>
                                <td>
                                    <asp:TextBox ID="TxtUserMSN" runat="server" class="form-control max20rem"></asp:TextBox>
                                    <asp:RangeValidator ID="RvMSN" runat="server" ErrorMessage="RangeValidator" ControlToValidate="TxtUserMSN"
                                        Display="Dynamic" MaximumValue="99999999999" MinimumValue="1">MSN格式不对</asp:RangeValidator>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <b>联系地址</b><br />
                                    申请人的居住地址
                                </th>
                                <td>
                                    <asp:TextBox ID="TxtUserAddress" runat="server" class="form-control max20rem"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <b>邮箱</b><br />
                                    申请人的电子邮箱地址
                                </th>
                                <td>
                                    <asp:TextBox ID="TxtUserEmail" runat="server" class="form-control max20rem"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RvEmail" runat="server" ControlToValidate="TxtUserEmail"
                                        Display="Dynamic" ErrorMessage="*" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">邮箱格式不对</asp:RegularExpressionValidator>
									<small class="text-muted">(格式为……@…….com/cn/net)</small>
                                </td>
                            </tr>
                        </tbody>
            </table>
        </div>
        <div class="tab-pane" id="Tabs2">
            <table class="table table-striped table-bordered table-hover sys_table">
                <tbody>
                    <tr>
                        <td colspan="2">
                            <textarea cols="80" id="TxtProjectRequire" name="infoeditor" rows="20" runat="server" style="margin:auto; width:800px; max-width:100%; height:300px;"></textarea>
                          <%=Call.GetUEditor("TxtProjectRequire",2) %>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="tab-pane" id="Tabs3">
            <table class="table table-striped table-bordered table-hover">   
                <tbody>
                    <tr>
                        <th class="w12rem_lg">
                            <b>流程管理</b><br />
                            导入流程<br />
                            <asp:Button ID="Button2" runat="server" Text="导入流程" CssClass="btn btn-info"
                                OnClientClick="return false;" />
                        </th>
                        <td>
                            <span id="Projects" name="Projects"></span>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div> 
    </div>
    <asp:Literal ID="lblHtml" runat="server"></asp:Literal>
    <div class="text-center">
        <asp:Button ID="Commit" runat="server" Text="提交" class="btn btn-info" OnClick="Commit_Click"  />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Cancel" runat="server" Text="重置" class="btn btn-outline-info" OnClick="Cancel_Click"  />
    </div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script src="/JS/Controls/ZL_Dialog.js"></script>
    <script>
        var userdiag = new ZL_Dialog();
        var userdiag1 = new ZL_Dialog();

        function ShowUserInfo() {
            var url = "/Common/Dialog/SelGroup.aspx";
            comdiag.maxbtn = false;
            ShowComDiag(url, "选择用户");
        }

        function UserFunc(json, select) {
            var uname = "";
            var uid = "";
            for (var i = 0; i < json.length; i++) {
                uname += json[i].UserName + ",";
                uid += json[i].UserID + ",";
            }
            if (uid) uid = uid.substring(0, uid.length - 1); {
                $("#TxtUserName").val(uname);
                //$("#CustomerID_H").val(uid);
            }
            CloseComDiag();
        }

        function UserFunc(json, select) {
            var uname = "";
            var uid = "";
            for (var i = 0; i < json.length; i++) {
                uname += json[i].UserName + ",";
                uid += json[i].UserID + ",";
            }
            if (uid) uid = uid.substring(0, uid.length - 1); { $("#TxtUserName").val(uname); }
            CloseComDiag();
        }
        function ShowUserInfo1() {
            userdiag1.title = "选择项目";
            userdiag1.url = "SelectProjects.aspx";
            userdiag1.ShowModal();
        }
        function closeModal() {
            userdiag.CloseModal();
            userdiag1.CloseModal();
        }
        function getHeader(name,id) {//弹窗选择用户得到用户名  
            $("#Leader").val(name);
            closeModal();
        }
        function getUser(name) {
            $("#TxtUserName").val(name);
            //$("#ProManageerID_H").val(id);
            closeModal();
        }
    </script>
</asp:Content>
