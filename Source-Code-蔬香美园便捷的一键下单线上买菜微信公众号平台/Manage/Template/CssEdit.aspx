<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CssEdit.aspx.cs" Inherits="ZoomLaCMS.Manage.Template.CssEdit" MasterPageFile="~/Manage/I/Index.master"  ValidateRequest="false"%>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <link rel="stylesheet" href="/Plugins/CodeMirror/lib/codemirror.css">
    <link rel="stylesheet" href="/Plugins/CodeMirror/theme/eclipse.css">
    <script src="/Plugins/CodeMirror/lib/codemirror.js"></script>
    <script src="/Plugins/CodeMirror/mode/css.js"></script>
    <script src="/Plugins/CodeMirror/addon/selection/active-line.js"></script>
    <script src="/Plugins/CodeMirror/mode/htmlmixed.js"></script>
    <title>样式编辑</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("TemplateSet.aspx","模板风格"),				
        new Bread("CssManage.aspx","风格管理"),				
        new Bread() {url="/{manage}/Template/CssEdit.aspx", text="样式编辑",addon="" }}
		)
    %>
	<div class="container-fluid pr-0">
	<div class="row sysRow list_choice">
<table class="table table-striped table-bordered table-hover">
    <tr class="title">
        <td> 
         <%--   <%=ShowPath.Trim()%> --%>
             <span style="float:left; margin-left:10px; margin-right:10px; font-weight:bold; margin-top:0.3em;">请输入风格名称:</span>
			   <div class="input-group mb-3 max20rem">
			 <input runat="server" id="TxtFilename" class="form-control text-right" />
			  <div class="input-group-append">
				<span class="input-group-text" id="basic-addon2">.css</span>
			  </div>
			</div>
    </td>
    </tr>
    <tr>
        <td>
          <asp:TextBox ID="textContent" runat="server" TextMode="MultiLine"></asp:TextBox>
        </td>
    </tr>
</table>
<div class="text-center w-100">
    <asp:Button ID="Button1" runat="server" Text="保存风格" OnClick="Button1_Click" class="btn btn-outline-info"/>
    <asp:Button ID="Button2" runat="server" Text="取消操作" OnClick="Button2_Click" class="btn btn-outline-info"/>
  
</div>
    <asp:HiddenField ID="HdnShowPath" runat="server" />
    <asp:HiddenField ID="Hdnmethod" runat="server" />
    <asp:HiddenField ID="HdnFilePath" runat="server" />
</div></div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript">
        var editor = CodeMirror.fromTextArea(document.getElementById("textContent"), {
            lineNumbers: true,
            styleActiveLine: true
        });
    </script>
</asp:Content>