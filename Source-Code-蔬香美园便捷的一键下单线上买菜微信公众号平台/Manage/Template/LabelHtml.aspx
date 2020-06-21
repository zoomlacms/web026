<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LabelHtml.aspx.cs" Inherits="ZoomLaCMS.Manage.Template.LabelHtml" MasterPageFile="~/Manage/I/Index.master"  ValidateRequest="false"%>

<asp:Content runat="server" ContentPlaceHolderID="head">
<link rel="stylesheet" href="/Plugins/CodeMirror/lib/codemirror.css">
<link rel="stylesheet" href="/Plugins/CodeMirror/theme/eclipse.css">
<script src="/Plugins/CodeMirror/lib/codemirror.js"></script>
<script src="/Plugins/CodeMirror/mode/xml.js"></script>
<script src="/Plugins/CodeMirror/mode/javascript/javascript.js"></script>
<script src="/Plugins/CodeMirror/addon/selection/active-line.js"></script>
<script src="/Plugins/CodeMirror/addon/edit/matchbrackets.js"></script>
<%--<script src="/Plugins/CodeMirror/mode/htmlmixed.js"></script>--%>
<title>静态标签</title>

</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ol class="breadcrumb navbar-fixed-top">
        <li class="breadcrumb-item"><a href="LabelManage.aspx">标签管理</a></li>
        <li class="breadcrumb-item">
            <asp:Label ID="LabelName_L" runat="server" />
            [<a href="../Config/DBTools/CreateTable.aspx" id="a1">添加新表</a>]
            <%--<a href="javascript:;" onclick="OneMode()">一步式编辑</a></li>--%>
    </ol>

    <ul id="sys_listTable" class="nav nav-tabs">
        <li class="nav-item"><a class="nav-link active" href="#Info0" data-toggle="tab">基本信息</a></li>
        <li class="nav-item"><a class="nav-link" href="#Info1" data-toggle="tab">标签内容</a></li>
    </ul>
    <div class="tab-content panel-body p-0">
        <div id="Info0" class="tab-pane active">
            <table class="table table-striped table-bordered tab-content sys_table">
                <tbody>
                    <tr>
                        <th class="w12rem_lg">标签名称</th>
                        <td class="text-left" data-auto="maxwidth">
                            <asp:TextBox ID="TxtLabelName" CssClass="form-control max20rem" runat="server" />
                            <asp:RequiredFieldValidator runat="server" ID="NReq" ControlToValidate="TxtLabelName" Display="Dynamic" ErrorMessage="请输入标签名称">*</asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="TxtLabelName" ErrorMessage="标签名称重复" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator></td>
                    </tr>
                    <tr>
                        <th>标签分类</th>
                        <td class="text-left">
							<div class="input-group mb-3">
							<asp:TextBox ID="TxtLabelType" CssClass="form-control max20rem" runat="server"></asp:TextBox>
							<div class="input-group-append">
							<asp:DropDownList ID="DropLabelType" CssClass=" form-control max20rem label_class" runat="server" OnSelectedIndexChanged="SelectCate" AutoPostBack="true"></asp:DropDownList>
							</div>
							</div>
						</td>
                    </tr>
                    <tr>
                        <th>标签说明</th>
                        <th class="text-left">
                            <asp:TextBox ID="TxtLabelIntro" CssClass="form-control max20rem label_explain" runat="server" TextMode="MultiLine" Columns="50" Rows="3"></asp:TextBox></td>
                    </tr>
                </tbody>

            </table>
        </div>
        <div id="Info1" class="tab-pane">
            <table class="table table-striped table-bordered tab-content sys_table">
                <tbody>
                    <tr>
                        <th>判断模式</th>
                        <td data-auto="maxwidth">
                            <asp:CheckBox ID="boolmodel" runat="server" Text="开启判断模式" AutoPostBack="True" />
                            <font color="red">[开启后将根据判断条件输出内容]</font>
                            <div class="ml-3">
                                <%=ZoomLa.Safe.SafeC.ReadFileStr("/manage/Template/label.htm") %>
                            </div>
                        </td>
                    </tr>
                    <tr id="isbool" runat="server" visible="false">
                        <th>模式设置</th>
                        <td>
                            <asp:DropDownList ID="Modeltypeinfo" CssClass="form-control max20rem label_num" runat="server" AutoPostBack="True">
                                <asp:ListItem Value="计数判断">计数判断</asp:ListItem>
                                <asp:ListItem Value="用户登录判断">用户登录判断</asp:ListItem>
                                <asp:ListItem Value="参数判断">参数判断</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="Valueroot" runat="server" Width="179px" onmousedown="inputtxt(this)" onfocus="inputtxt(this)" value="这里放入标签"></asp:TextBox>
                            <asp:DropDownList ID="addroot" CssClass="form-control max20rem label_num" runat="server" Visible="false" AutoPostBack="True">
                                <asp:ListItem Value="循环计算">循环计算</asp:ListItem>
                                <asp:ListItem Value="一直累加">一直累加</asp:ListItem>
                            </asp:DropDownList>
                            <asp:DropDownList ID="setroot" CssClass="form-control max20rem label_num" runat="server">
                                <asp:ListItem Value="大于">大于</asp:ListItem>
                                <asp:ListItem Value="等于" Selected="True">等于</asp:ListItem>
                                <asp:ListItem Value="小于">小于</asp:ListItem>
                                <asp:ListItem Value="不等于">不等于</asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox ID="Modelvalue" runat="server" CssClass="form-control max20rem"></asp:TextBox>
                            <asp:Label ID="Label3" runat="server" ForeColor="#339933" Visible="False" Font-Bold="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="text-right" colspan="2">
                            <table class="w-100">
                                <tr class="sys_move_list">
                                    <td id="frmTitle" class="sys_Label_l">
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                            <tbody id="ss">
                                                <tr align="center">
                                                    <td>
                                                        <div id="Tab1_header">
                                                            <ul class="nav nav-tabs">
                                                                <li class="nav-item" id="TabTitle0" class="active"><a  class="nav-link active" href="#Tabs0" data-toggle="tab">自定标签</a></li>
                                                                <li class="nav-item" id="TabTitle1"><a class="nav-link" href="#Tabs1" data-toggle="tab">系统标签</a></li>
                                                                <li class="nav-item" id="TabTitle2"><a class="nav-link" href="#Tabs2" data-toggle="tab">扩展函数</a></li>
                                                            </ul>
                                                            <div class="tab-content">
                                                                <div class="tab-pane active" id="Tabs0" runat="server">
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered">
                                                                        <tbody>
                                                                            <tr align="center">
                                                                                <td>
                                                                                    <asp:DropDownList ID="DDLCate" runat="server" OnSelectedIndexChanged="ChangeCate"
                                                                                        AutoPostBack="true">
                                                                                    </asp:DropDownList></td>
                                                                            </tr>
                                                                            <tr align="center">
                                                                                <td>
                                                                                    <div style="overflow: auto; height: 370px">
                                                                                        <asp:Label ID="LblLabel" runat="server"></asp:Label>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                                <div class="tab-pane" id="Tabs1" runat="server">
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered">
                                                                        <tbody>
                                                                            <tr align="center">
                                                                                <td>
                                                                                    <div style="overflow: auto; height: 410px">
                                                                                        <asp:Label ID="LblSysLabel" runat="server"></asp:Label>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                                <div class="tab-pane" id="Tabs2" runat="server">
                                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table table-striped table-bordered">
                                                                        <tbody>
                                                                            <tr align="center">
                                                                                <td>
                                                                                    <div style="overflow: auto; height: 410px">
                                                                                        <asp:Label ID="LblFunLabel" runat="server"></asp:Label>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </tbody>
                                                                    </table>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td align="left">
                                        <div id="Textarea">
                                            <asp:TextBox TextMode="MultiLine" runat="server" ID="textContent"></asp:TextBox>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr id="s1" runat="server" visible="false">
                        <td class="w-100" colspan="2"><strong>标签内容:(<font color="red">不满足</font>判断)</strong></td>
                    </tr>
                    <tr id="s2" runat="server" visible="false" onmouseover="this.className='tdbgmouseover'"
                        onmouseout="this.className='tdbg'">
                        <td class="w-100 text-center" colspan="2">
                            <table class="w-100">
                                <tr>
                                    <td align="left">
                                        <asp:TextBox TextMode="MultiLine" runat="server" CssClass="form-control max20rem" ID="falsecontent" Style="max-width: 100%; height: 231px;"></asp:TextBox></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <table class="table table-striped table-bordered tab-content">
                <tr>
                    <td colspan="2" >
						<div class="input-group mb-3">
						<select id="selstatus" class="form-control max20rem" onchange="selPage(this)">
                            <option value="0">基本信息</option>
                            <option value="1">标签内容</option>
                        </select>
						  <div class="input-group-append">
							<a id="rel" href="#Info0" onclick="changeIndex(0,'rel')" class="btn btn-outline-info" style="display: none;" data-toggle="tab">上一步</a> <a id="next" href="#Info1" onclick="changeIndex(1,'next')" class="btn btn-outline-info" data-toggle="tab">下一步</a>
                        <asp:Button ID="Button1" runat="server" Text="保存标签" CssClass="btn btn-info" OnClick="BtnSave_Click" Style="cursor: pointer; cursor: pointer;" />
                        <input id="BtnCancel" type="button" class="btn btn-outline-danger" value="取　消" onclick="window.location.href = 'LabelManage.aspx'" style="cursor: pointer; cursor: pointer;" />
						  </div>
						</div>
						
                </tr>
        </table>
    </div>
    <asp:HiddenField runat="server" ID="indexStatu_Hid" />
    <asp:HiddenField runat="server" ID="editor_hid" Value="" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/Plugins/CodeMirror/LabelCall.js?v=10"></script>
<script src="/JS/Common.js"></script>
<script type="text/javascript">
        $("body").ready(function () {
            $("[data-auto=maxwidth]").width($("#content").width());
            if ($("#indexStatu_Hid").val()=="1") {
                $("#next").click();
                $("#selstatus").val("1");
            }
        });
        function selPage(data) {
            if ($(data).val() == 1) {
                $("#next").click();
            } else {
                $("#rel").click();
            }
        }
        function changeIndex(index, staue) {
            if (staue == "next") {
                checkData();
                $("[data-index=" + (index - 1) + "]").removeClass("active");
                $("#next").hide();
                $("#rel").show();
                $("#selstatus").val("1");
				$("#sys_listTable .nav-link").eq(index).click();
				
            } else {
                $("[data-index=" + (index + 1) + "]").removeClass("active");
                $("#rel").hide();
                $("#next").show();
                $("#selstatus").val("0");
				$("#sys_listTable .nav-link").eq(index).click();
            }
            $("[data-index=" + index + "]").addClass("active");
            if ($("#editor_hid").val() == "")
            {
                setTimeout(function () { editor.refresh(); }, 500); $("#editor_hid").val("1");
            }
        }
        function changeStaus(staue) {
            if (staue == "next") {
                $("#rel").hide();
                $("#next").show();
                $("#selstatus").val("0");
            } else {
                checkData();
                $("#next").hide();
                $("#rel").show();
                $("#selstatus").val("1");
            }
        }
        function checkData() {
            if ($("#TxtLabelName").val()=="") {
                alert("标签名不能为空");
                setTimeout(function () {$("#rel").click()},100);
            }
        }
        var diag = new ZL_Dialog();
        function opentitle(url, title) {
            diag.url = url;
            diag.title = title;
            diag.ShowModal();
        }
        function closeCuModal() {
            diagLabel.CloseModal();
        }
        function inputtxt(cc) {
            if (cc.value == "这里放入标签") {
                cc.value = '';
            }
        }
    </script> 
</asp:Content>
