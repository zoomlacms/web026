﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddSearch.aspx.cs" MasterPageFile="~/Manage/I/Index.master" Inherits="ZoomLaCMS.Manage.Config.AddSearch" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>设定导航</title>
<link type="text/css" href="/dist/css/bootstrap-switch.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("SearchFunc.aspx","管理导航"),
        new Bread() {url="", text="管理导航管理",addon="" }}
		)
    %>
<asp:HiddenField ID="hideid" runat="server" />
<div class="card list_choice">
	<div class="card-header text-center">设定导航</div>
	<div class="card-body">
		<table class="table table-striped table-bordered sys_table">
			<tr>
				<th class="max20rem">
					功能名称<span class="text-danger">*</span>
				</th>
				<td>
					<asp:TextBox ID="txtName" onblur="checkname()" runat="server" class="form-control max20rem"></asp:TextBox>
					<small class="text-muted">方便记忆的名称</small>
							<span class="text-dange" id="txtName_span"></span>
					<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ErrorMessage="名称不能为空！" Display="Dynamic" ControlToValidate="txtName"></asp:RequiredFieldValidator>
					<br />
					<span runat="server" id="Span1"></span>
				</td>
			</tr>
			<tr>
				<th>
					文件路径<span class="text-danger">*</span>
				</th>
				<td>
					<asp:TextBox ID="txtFileUrl" runat="server" class="form-control max20rem"></asp:TextBox>
					<small class="text-muted">您可以直接填入系统内文件名,以便后台访问,如[/manage/Config/SiteInfo.aspx]为系统配置,或输入外部网址提交</small>
					</td>
			</tr>
			<tr>
				<th>图标地址</th>
				<td>
					<div class="input-group mb-3">
					  <asp:TextBox ID="ItemIcon_T" runat="server" CssClass="form-control max20rem"></asp:TextBox>
					  <div class="input-group-append">
						<i id="ItemIcon_T_icon"></i>
					    <input type="button" class="btn btn-info" onclick="ShowComDiag('/common/icon2.html', '选择图标');" value="选择图标" />
					  </div>
					</div>
					
				</td>
			</tr>
			<tr>
				<th>打开方式</th>
				<td>
					<asp:RadioButtonList ID="rdoOpenType" runat="server" RepeatDirection="Horizontal">
						<asp:ListItem Selected="True" Value="0">原窗口打开</asp:ListItem>
						<asp:ListItem Value="1">新窗口打开</asp:ListItem>
					</asp:RadioButtonList>
				</td>
			</tr>
			<tr>
				<th>支持移动</th>
				<td>
					<asp:RadioButtonList ID="SupportMobile" runat="server" RepeatDirection="Horizontal">
						<asp:ListItem Selected="True" Value="1">支持</asp:ListItem>
						<asp:ListItem Value="0">不支持</asp:ListItem>
					</asp:RadioButtonList>
				</td>
			</tr>
			<tr>
				<th>块大小</th>
				<td>
					<asp:RadioButtonList ID="MotroSize" runat="server" RepeatDirection="Horizontal">
						<asp:ListItem Selected="True" Value="3">大</asp:ListItem>
						<asp:ListItem Value="2">中</asp:ListItem>
						<asp:ListItem Value="1">小</asp:ListItem>
					</asp:RadioButtonList>
				</td>
			</tr>
			<tr>
				<th>块颜色</th>
				<td>
					<asp:TextBox runat="server" ID="BKColor_T" class="form-control max20rem color_text"></asp:TextBox>
				</td>
			</tr>
		</table>
	</div>
	<div class="alert alert-light text-center">
		<button type="button" id="Edit_Btn" runat="server" class="btn btn-info" onclick="CheckSubmit()">添加导航</button>
		<asp:Button ID="EBtnSubmit" class="btn btn-info" Text="添加导航" Style="display: none;" runat="server" OnClick="EBtnSubmit_Click" />
		<asp:HiddenField ID="EditSearchName_Hid" runat="server" />
		<input type="button" class="btn btn-outline-info" name="Button2" value="返回列表" onclick="location.href = 'SearchFunc.aspx'" id="Button2" />
	</div>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<link rel="stylesheet" type="text/css" href="/Design/JS/Plugs/color/bootstrap.colorpickersliders.min.css"  />
<script src="/dist/js/bootstrap-switch.js"></script>
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/Design/JS/Plugs/color/tinycolor-min.js"></script>
<script src="/Design/JS/Plugs/color/bootstrap.colorpickersliders.min.js"></script>
<script>   
$(function () {
	$("[name='linktype_ch']").change(function () {//显示用户组
		ShowUserGroup();
	});
	ShowUserGroup();
	//全选操作
	$("#usercheck_ch").click(function () {
		var obj = $(this);
		obj.closest('td').find('input').each(function (i,v) {
			$(v)[0].checked = obj[0].checked;
		});
	});
	$(".color_text").ColorPickerSliders({
		size: 'default', placement: 'bottom', color: $(this).val(), swatches: true, sliders: false, hsvpanel: true, previewformat: "hex",
		onchange: function (container, color) {
			var $input = $(this.connectedinput.context);
			var hex = color.tiny.toHexString()
			$input.val(hex);
		}
	});
})
function ShowUserGroup() {
	if ($("[name='linktype_ch']:checked").val() == "3")
		$(".user_hid_set").show();
	else
		$(".user_hid_set").hide();
}
function CheckUserType() {
	$("[name='linktype_ch'][value=3]")[0].checked = true;
}
//检查名字是否重复
function checkname() {
	if ($("#EditSearchName_Hid").val() != "" && $("#EditSearchName_Hid").val() == $("#txtName").val())
	{
		if(formflag)
		{ $("#EBtnSubmit").click(); }
		return;
	}
	$.post('AddSearch.aspx', { action: 'checkname', name: $("#txtName").val() }, function (data) {
		if (data == "-1") {
			$("#Edit_Btn").attr('disabled', 'disabled');
			$("#txtName_span").text('功能名重复!请重新修改功能名');
			formflag = false;
		}
		else {
			$("#txtName_span").text('');
			$("#Edit_Btn").removeAttr('disabled');
			if (formflag)
			{ $("#EBtnSubmit").click(); }
		}
	})
}
var formflag=false;//表单控制
function CheckSubmit() {
	formflag = true;
	checkname();
}
//----------------
var zlicon = { id: "" };
zlicon.back = function (icon) {
	if (!icon) { icon = $(zlicon.id).val(); }
	$(zlicon.id).val(icon);
	$(zlicon.id + "_icon").attr("class", icon);
	CloseComDiag();
}
zlicon.init = function (id) {
	zlicon.id = id;
	zlicon.back($(id).val());
	$(id).change(function () { setTimeout(zlicon.back, 50); });
}
zlicon.init("#ItemIcon_T");
</script>
</asp:Content>
