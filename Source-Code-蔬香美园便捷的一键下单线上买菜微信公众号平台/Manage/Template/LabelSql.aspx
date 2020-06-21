﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LabelSql.aspx.cs" Inherits="ZoomLaCMS.Manage.Template.LabelSql"  MasterPageFile="~/Manage/I/Index.master" ValidateRequest="false" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<link rel="stylesheet" href="/Plugins/CodeMirror/lib/codemirror.css">
<link rel="stylesheet" href="/Plugins/CodeMirror/theme/eclipse.css">
<script src="/Plugins/CodeMirror/lib/codemirror.js"></script>
<script src="/Plugins/CodeMirror/mode/xml.js"></script>
<script src="/Plugins/CodeMirror/mode/javascript/javascript.js"></script>
<script src="/Plugins/CodeMirror/addon/selection/active-line.js"></script>
<script src="/Plugins/CodeMirror/addon/edit/matchbrackets.js"></script>
<script src="/Plugins/CodeMirror/mode/htmlmixed.js"></script>
<script src="/Plugins/CodeMirror/mode/css.js"></script>
<script src="/Plugins/Third/bootstrap-select/js/bootstrap-select.js"></script>
<link href="/Plugins/Third/bootstrap-select/css/bootstrap-select.css" rel="stylesheet" />
<script>
    //必须顶部声明
	
    function replaceTableDP() {
        $('#TableList_DP,#TableList2_DP').selectpicker({
            hideDisabled: true,
            liveSearch: true,
            maxOptions: 1
        });
    }
</script>
<title>标签查询</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<asp:ScriptManager ID="SM1" runat="server"></asp:ScriptManager>
<div id="BreadDiv" class="container-fluid mysite">
     <div class="row">
            <ol class="breadcrumb navbar-fixed-top w-100">
                <li class="breadcrumb-item"><a href="LabelManage.aspx">标签管理</a></li>
                <li class="breadcrumb-item">
                    <asp:Label ID="Bread_L" runat="server" />
                    <a href="../Config/DBTools/CreateTable.aspx">[添加新表]</a>
<%--                    <a href="labelSqlOne.aspx?LabelName=<%:LabelName %>">[一步式编辑]</a></li>--%>
                <%=Call.GetHelp(25) %>
            </ol>
        </div>
</div>

<asp:UpdatePanel ID="LabelPanel" runat="server">	<ContentTemplate>
<asp:Wizard ID="Wizard1" runat="server" DisplaySideBar="False"  class="w-100" ActiveStepIndex="0">
<HeaderTemplate></HeaderTemplate>
<WizardSteps>
  <asp:WizardStep ID="WizardStep1" EnableTheming="true" runat="server" Title="step1">
	<table class="table table-striped table-bordered table-hover sys_table">
	  <tr><td class="spacingtitle text-center" colspan="2">第一步：基本信息</td></tr>
	  <tr>
		<th class="w12rem_lg">标签名称</th>
		<td class="text-left"><asp:TextBox ID="LabelName_T" class="form-control max20rem" runat="server" />
		  <asp:RequiredFieldValidator runat="server" ID="S1R1" ControlToValidate="LabelName_T" Display="Dynamic" ForeColor="Red" ErrorMessage="必须输入名称" SetFocusOnError="True" />
		  <asp:CustomValidator ID="S1C1" Display="Dynamic" runat="server" ControlToValidate="LabelName_T" ErrorMessage="名称重复" OnServerValidate="S1C1_ServerValidate" SetFocusOnError="True" /></td>
	  </tr>
	  <tr>
		<th>标签分类</th>
		<td class="text-left">
		  <div class="input-group mb-3">
		  <asp:TextBox ID="LabelCate_T" class="form-control max20rem" runat="server"></asp:TextBox>
		  <div class="input-group-append">
			<asp:DropDownList ID="LabelCate_DP" DataTextField="Name" DataValueField="Name" CssClass="form-control max20rem" runat="server" onchange="changecate(this);"></asp:DropDownList>
		  <asp:RequiredFieldValidator CssClass="tips" Display="Dynamic" ID="S1R2" runat="server" ControlToValidate="LabelCate_T" ErrorMessage="分类不能为空" ForeColor="Red" />
		  </div>
		</div>
		  
		  </td>
	  </tr>
	  <tr>
		<th>标签类型</th>
		<td><asp:RadioButtonList ID="LabelType_Rad" runat="server" RepeatDirection="Horizontal">
			<asp:ListItem Value="2" Selected="True">动态标签</asp:ListItem>
			<asp:ListItem Value="4">分页列表标签</asp:ListItem>
			<asp:ListItem Value="3">数据源标签</asp:ListItem>
		  </asp:RadioButtonList></td>
	  </tr>
	  <tr>
		<th>标签说明</th>
		<td><asp:TextBox ID="Desc_T" class="form-control max20rem" runat="server" TextMode="MultiLine" Rows="5"></asp:TextBox></td>
	  </tr>
	<%--  <tr>
		<td class="text-right"><strong>数据架构：</strong></td>
		<td><asp:TextBox runat="server" CssClass="form-control max20rem" ID="schema_Text"></asp:TextBox>
		  <span style="margin-left:5px;line-height:30px;color:green;"><small>*常规应用忽略此项（私有架构定义时用于区别DBO）</small> </span></td>
	  </tr>--%>
        <tr>
            <td></td>
            <td>
                <asp:DropDownList ID="Step_DP" CssClass="form-control pull-left w12rem_lg" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Step_DP_SelectedIndexChanged">
                    <asp:ListItem Value="0" Text="基本信息"></asp:ListItem>
                    <asp:ListItem Value="1" Text="数据查询"></asp:ListItem>
                    <asp:ListItem Value="2" Text="参数设定"></asp:ListItem>
                    <asp:ListItem Value="3" Text="标签内容"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="StartNextButton" runat="server" CommandName="MoveNext" Text="下一步" class="btn btn-outline-info ml-2" OnClick="StartNextButton_Click" />
                <input type="button" value="保存标签" class="btn btn-info" onclick="$('#Save_Btn').click();;" />
                <a href="LabelManage.aspx" class="btn btn-link"><i class="fa fa-close" aria-hidden="true"></i> 取消</a>
                <asp:LinkButton OnClick="UseLable_Click" class="btn btn-link" runat="server"><i class="fa fa-copy" aria-hidden="true"> </i> 引用标签</asp:LinkButton>
            </td>
        </tr>
	</table>
      <div>
          <strong>辅助说明:</strong>本操作用于定义标签基本信息,标签建好后可以在前台任意位置调用输出动态数据：
		  <ul class="disc">
              <li>动态标签可以在任何页面引用,分页列表支持分页显示,数据源标签可节省查询效率,需要在模板中引用数据输出。</li>
              <li>动态标签的调用格式为<code>{ZL.Label id=&quot;标签名&quot; NodeID=&quot;0&quot; /}</code>，其中 NodeID="0" 为变量参数，可于第二步编辑中定义或增减变量。</li>
              <li>标签支持在任意动态页面输出，如<code>&#60;%Call.Label("{ZL.Label id=\"标签名称\" NodeID=\"91\" /}"); %&#62;</code>方法则能在非模板引擎页输出动态标签。</li>
			  <li>在MVC页面则应用下面方法引入：<code>@MvcHtmlString.Create(Call.GetLabel(&quot;{ZL.Label id=\&quot;输出指定节点下文章列表_不分页\&quot; NodeID=\&quot;4\&quot; ShowNum=\&quot;5\&quot; /}&quot;))</code></li>
              <li>系统采用智能多库算法，数据库名请不要采用数字开头并夹带小数点等特殊符号，如[2009data.1]格式则是非法数据库名格式，不符合数据库联查标准。</li>
          </ul>
      </div>
  </asp:WizardStep>
  <asp:WizardStep ID="WizardStep2" runat="server" Title="step2">
	<table class="table table-striped table-bordered sys_table">
	  <tr>
		<td class="spacingtitle text-center" colspan="2">第二步：数据查询</td>
	  </tr>
	  <tr colspan="2"><th class="text-center">选择数据</th></tr>
	  <tr>
<!--          <th class="text-right w12rem_lg">选择数据</th>-->
          <td>
              <table class="table table-striped table-bordered">
                  <tr>
                      <th class="w12rem_lg">请选择数据库</th>
                      <td>
                          <asp:DropDownList ID="DBList_DP" CssClass="form-control max20rem" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DBList_DP_SelectedIndexChanged" /></td>
                      <th>请选择数据库</th>
                      <td><asp:DropDownList ID="DBList2_DP" CssClass="form-control max20rem" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DBList2_DP_SelectedIndexChanged" /></td>
                  </tr>
                  <tr>
                        <th>主表</th>
                      <td>
                          <asp:DropDownList ID="TableList_DP" DataTextField="Name" DataValueField="Name" CssClass="form-control max20rem" runat="server" AutoPostBack="True" OnSelectedIndexChanged="TableList_DP_SelectedIndexChanged" /></td>
                      <th class="text-right">从表</th>
                      <td>
                          <asp:DropDownList ID="TableList2_DP" DataTextField="Name" DataValueField="Name" CssClass="form-control max20rem" runat="server" AutoPostBack="True" OnSelectedIndexChanged="TableList2_DP_SelectedIndexChanged" /></td>
                  </tr>
                  <tr>
                         <th>输出字段</th>
                      <td>
                          <asp:ListBox ID="FieldList_DP" DataTextField="Name" DataValueField="Name" CssClass="form-control max20rem h14rem" runat="server"  SelectionMode="Multiple" /></td>
                      <th class="text-right">输出字段</th>
                      <td>
                          <asp:ListBox ID="FieldList2_DP" DataTextField="Name" DataValueField="Name" CssClass="form-control max20rem h14rem" runat="server" SelectionMode="Multiple" /></td>
                  </tr>
                  <tr><td colspan="4">
				  <small class="text-muted">先取数据表后再选择输出字段，支持Ctrl或Shift选取操作</small>
				  </td></tr>
              </table>
          </td>
	  </tr>
	  <tr colspan="2"><th class="text-center">约束字段</th></tr>
      <tr id="Join_Div" runat="server" visible="false">
		  <td>
                <asp:DropDownList ID="SqlJoin_DP" runat="server" CssClass="form-control pull-left" Width="120" AutoPostBack="True" OnSelectedIndexChanged="SqlTable_Change">
				<asp:ListItem Value="LEFT JOIN">Left</asp:ListItem>
				<asp:ListItem Value="INNER JOIN">Inner</asp:ListItem>
				<asp:ListItem Value="OUTER JOIN">Outer</asp:ListItem>
				<asp:ListItem Value="RIGHT JOIN">Right</asp:ListItem>
			  </asp:DropDownList>
			  <asp:DropDownList ID="OnField_DP" DataTextField="Name" DataValueField="Name" runat="server" CssClass="form-control pull-left w12rem_lg" AutoPostBack="True" OnSelectedIndexChanged="SqlTable_Change" />
			  <span class="tips pull-left" style="margin-right:5px;">=</span>
			  <asp:DropDownList ID="OnField2_DP" DataTextField="Name" DataValueField="Name" runat="server" CssClass="form-control pull-left w12rem_lg" AutoPostBack="True" OnSelectedIndexChanged="SqlTable_Change" />
		  </td>
		</tr>
	  <tr colspan="2"><th class="text-center">查询表</th></tr>
      <tr>
		  <td><asp:TextBox runat="server" ID="SqlTable_T" TextMode="MultiLine" class="form-control m50rem_50" Height="90"></asp:TextBox>
			<small class="text-muted">从选择数据中选择主表，若选择了从表，请在约束字段中设定表连接条</small>
			<asp:RequiredFieldValidator ID="S2R1" runat="server" cssclass="text-danger" ErrorMessage="查询表不能为空!" ControlToValidate="SqlTable_T" /></td>
		</tr>
	  <tr colspan="2"><th class="text-center">查询字段</th></tr>	
      <tr>
		  <td><asp:TextBox runat="server" ID="SqlField_T" TextMode="MultiLine" class="form-control m50rem_50" Height="90"></asp:TextBox>
			<br />
              <asp:Button ID="SqlField_Btn" class="btn btn-info" runat="server" Text="查询字段" OnClick="SqlField_Btn_Click" />
			  <small class="text-muted">从输出字段中选择查询的字段，未选字段点击为全选操作</small>
		  </td>
		</tr>
	  <tr>
		<td>
			<asp:DropDownList ID="Step2_DP" runat="server" CssClass="form-control pull-left" Width="120" AutoPostBack="true" OnSelectedIndexChanged="Step_DP_SelectedIndexChanged">
			  <asp:ListItem Value="0" Text="基本信息"></asp:ListItem>
			  <asp:ListItem Value="1" Text="数据查询"></asp:ListItem>
			  <asp:ListItem Value="2" Text="参数设定"></asp:ListItem>
			  <asp:ListItem Value="3" Text="标签内容"></asp:ListItem>
			</asp:DropDownList>
			<asp:Button ID="PreviousButtonStep3" runat="server" CausesValidation="False" class="btn btn-outline-info ml-2" CommandName="MovePrevious" Text="上一步" OnClick="PreviousButtonStep3_Click" />
			<asp:Button ID="NextButtonStep3" runat="server" class="btn btn-outline-info" CommandName="MoveNext" OnClick="StartNextButton_Click" Text="下一步" />            
            <input type="button" value="保存标签" class="btn btn-info" onclick="$('#Save_Btn').click();;" />
			<input id="Button9" type="button" class="btn btn-link" value="取消" onclick="window.location.href='LabelManage.aspx'" style="cursor: pointer; cursor: pointer;" />
            <asp:LinkButton OnClick="UseLable_Click" class="btn btn-link" runat="server" ><i class="fa fa-copy" aria-hidden="true"> </i> 引用标签</asp:LinkButton>
            </td>
	  </tr>
	</table>
    <div>
          <strong>辅助说明:</strong>数据库一般查询主数据库[仅高级版本支持从数据库]：
		  <ul class="disc">
              <li>多表查询应采用ID关联,比如文章模型则采用ZL_CommonModel left join ZL_C_Article on ZL_CommonModel.ItemID=ZL_C_Article.ID方法关联查询。</li>
              <li>为保持查询效率，每次查询请撷取所需字段，从而提升效率。</li>
              <li>建立标签时应注意多表间的逻辑，点此<a href="javascript:void(0);" onclick="javascript:window.open('http://www.z01.com/learn')">下载数据字典</a>以提升开发效率。</li>
          </ul>
      </div>
    <img src="/Images/nopic.gif" style="display:none;" onload="replaceTableDP();"/>
  </asp:WizardStep>
  <asp:WizardStep ID="WizardStep3" runat="server" Title="step3">
	<table class="table table-striped table-bordered sys_table">
	  <tr>
		<td class="spacingtitle text-center" colspan="2">第三步：参数设定</td>
	  </tr>
	  <tr>
		<th class="w12rem_lg">添加参数</th>
		<td><table class="table table-striped table-bordered" style="text-align: center">
			<tr>
			  <td class="td_m">参数名称 </td><td class="td_m">默认值 </td><td class="max20rem">参数类型 </td><td>参数说明 </td><td class="max20rem">操作 </td>
			</tr>
			<asp:Repeater ID="repParam" runat="server" OnItemCommand="repParam_ItemCommand">
			  <ItemTemplate>
				<tr>
				  <td class="text-center"><%#Eval("ParamName")%></td>
				  <td class="text-center"><%#Eval("ParamValue") %>
				  <td class="text-center"><%#GetParamType(Eval("ParamType",""))%></td>
				  <td class="text-center"><%#Eval("ParamDesc")%></td>
				  <td class="text-center">
					<asp:LinkButton runat="server" CommandName="Edit" CommandArgument='<%# Eval("Param") %>'><i class="fa fa-pencil" title="修改" style="font-size:18px;"></i></asp:LinkButton>
					<asp:LinkButton runat="server" CommandName="Del" CommandArgument='<%# Eval("Param") %>'><i class="fa fa-trash" title="删除" style="font-size:18px;margin-left:10px;"></i></asp:LinkButton></td>
				</tr>
			  </ItemTemplate>
			</asp:Repeater>
            <tr>
                <td><asp:TextBox ID="TxtParamName" CssClass="form-control max20rem required" runat="server" placeholder="参数名称" /></td>
                <td><asp:TextBox ID="TxtParamValue" runat="server" placeholder="默认值" CssClass="form-control max20rem" /></td>
                <td class="tdbg max20rem"><asp:DropDownList ID="DDLParamType" CssClass="form-control" runat="server">
				  <asp:ListItem Selected="True" Value="1">普通参数</asp:ListItem>
				  <asp:ListItem Value="2">页面参数</asp:ListItem>
				  <asp:ListItem Value="3">单选参数</asp:ListItem>
				  <asp:ListItem Value="4">多选参数</asp:ListItem>
				</asp:DropDownList></td>
                <td><asp:TextBox ID="TxtParamDesc" runat="server" placeholder="参数说明" CssClass="form-control" /></td>
			    <td>
                    <asp:Button ID="BtnAddParam" runat="server" Text="添加" class="btn btn-info" OnClientClick="return VoteCheck();" OnClick="BtnAddParam_Click" Style="cursor: pointer;" />
                    <asp:HiddenField ID="Param_Hid" runat="server" /><asp:HiddenField ID="HdnTempParam" runat="server" />
			    </td>
            </tr>
		  </table></td>
	  </tr>
	  <tr>
		<th>参数[可拖放]</th>
		<td><div id="plist" class="plist">
			<asp:Label ID="attlist" runat="server"></asp:Label>
		  </div></td>
	  </tr>
	  <tr>
		<th>查询条件</th>
		<td>
            <div id="gridviewclause" class="input-group fielddiv m50rem_50">
                <asp:DropDownList ID="Where_Join_DP" CssClass="form-control" style="border-right:none;width:80px;" runat="server">
			      <asp:ListItem Selected="True">And</asp:ListItem>
			      <asp:ListItem>OR</asp:ListItem>
			    </asp:DropDownList>
			    <asp:DropDownList ID="Where_Table_DP" CssClass="form-control" style="border-right:none;width:100px;" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Where_Table_DP_SelectedIndexChanged">
			      <asp:ListItem Selected="True" Value="1">主表</asp:ListItem>
			      <asp:ListItem Value="2">从表</asp:ListItem>
			    </asp:DropDownList>
			    <asp:DropDownList ID="Where_Field_DP" DataTextField="Name" DataValueField="Name" CssClass="form-control" runat="server" style="border-right:none;width:140px;"/>
			    <asp:DropDownList ID="Where_OPCode_DP" CssClass=" form-control" style="border-right:none;width:100px;" runat="server">
			      <asp:ListItem>等于</asp:ListItem>
			      <asp:ListItem>大于</asp:ListItem>
			      <asp:ListItem>小于</asp:ListItem>
			      <asp:ListItem>大于等于</asp:ListItem>
			      <asp:ListItem>小于等于</asp:ListItem>
			      <asp:ListItem>不等于</asp:ListItem>
			      <asp:ListItem>在</asp:ListItem>
			      <asp:ListItem>象</asp:ListItem>
			      <asp:ListItem>不在</asp:ListItem>
			    </asp:DropDownList>
			    <asp:TextBox ID="Where_Value_T" class="form-control" style="border-right:none;width:150px;" runat="server"></asp:TextBox>
                <span class="input-group-append">
                    <asp:Button ID="Where_Btn" runat="server" class="btn btn-info" Text="添加查询条件" OnClick="Where_Btn_Click" />
                </span>
            </div>
			
			<asp:TextBox ID="Where_T" runat="server" class="form-control"  style="max-width:500px; margin-top:10px;height:100px;" TextMode="MultiLine"></asp:TextBox>
		  </td>
	  </tr>
	  <tr>
		<th>字段排序</th>
		<td>
            <div id="Div2" class="fielddiv">
                <div class="input-group m50rem_50">
                    <asp:DropDownList ID="Order_Table_DP" CssClass="form-control" style="border-right:none;width:100px;" runat="server" AutoPostBack="True" OnSelectedIndexChanged="Order_Table_DP_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="1">主表</asp:ListItem>
                        <asp:ListItem Value="2">从表</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="Order_Field_DP" DataTextField="Name" DataValueField="Name" CssClass="form-control" runat="server" style="border-right:none;width:150px;" />
                    <asp:DropDownList ID="Order_DP" CssClass="form-control" style="border-right:none;width:100px;" runat="server">
                        <asp:ListItem Value="DESC">降序</asp:ListItem>
                        <asp:ListItem Value="ASC">升序</asp:ListItem>
                    </asp:DropDownList>
                    <span class="input-group-btn">
                        <asp:Button ID="Order_Btn" class="btn btn-info" runat="server" Text="添加排序字段" OnClick="Order_Btn_Click" ValidationGroup="false" />
                    </span>
                </div>
			<asp:TextBox ID="Order_T" class="form-control" runat="server" style="max-width:500px; margin-top:10px;" Rows="7" TextMode="MultiLine" Height="100"></asp:TextBox>
			<br />
			<small class="text-muted">(提示：当标签为分页标签时,字段排序不能为空)</small>
		  </div></td>
	  </tr>
	  <tr>
		<th>数据数目</th>
		<td><asp:TextBox ID="PSize_T" class="form-control max20rem" runat="server" Text="10"></asp:TextBox></td>
	  </tr>
	  <tr><td></td>
		<td>
			<asp:DropDownList ID="Step3_DP" CssClass="form-control pull-left" Width="120" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Step_DP_SelectedIndexChanged">
			  <asp:ListItem Value="0" Text="基本信息"></asp:ListItem>
			  <asp:ListItem Value="1" Text="数据查询"></asp:ListItem>
			  <asp:ListItem Value="2" Text="参数设定"></asp:ListItem>
			  <asp:ListItem Value="3" Text="标签内容"></asp:ListItem>
			</asp:DropDownList>
			<asp:Button ID="Pervious3_Btn" runat="server" CausesValidation="False" class="btn btn-outline-info" CommandName="MovePrevious" Text="上一步" OnClick="PreviousButtonStep3_Click" />
			<asp:Button ID="ToFinal_Btn" runat="server" class="btn btn-outline-info" CommandName="MoveNext" OnClick="StartNextButton_Click" Text="下一步" />
			<input type="button" value="保存标签" class="btn btn-info" onclick="$('#Save_Btn').click();;" />
			<input id="Button11" type="button" class="btn btn-link" value="取　消" onclick="window.location.href='LabelManage.aspx'" style="cursor: pointer;" />
            <asp:LinkButton OnClick="UseLable_Click" class="btn btn-link" runat="server" ><i class="fa fa-copy" aria-hidden="true"> </i> 引用标签</asp:LinkButton>
		  </td>
	  </tr>
	</table>
	<div style="margin-top:5px;">
        <ul class="disc">
			<li>支持中文名定义参数,参数可以在前台模板中传递数值。</li>
			<li>支持采用页面采数传递信息。</li>
			<li>参数可自由拖放到查询条件、排序规则、数据条目等位置。</li>
			<li>参数支持普通参数、页面参数、单选参数、多选参数四种模式，其中单选参数与多选参数的值以$符号切割，如：华东$华南$华西$华北。</li>
			<li>查询条件支持嵌入T-sql语法规则，例如一条查询指定节点下的二级数据规则，可设定条件：NodeID in (select NodeID from ZL_Node where ParentID=@NodeID) or NodeID=@NodeID,当然也可以采用更高效的父节点属性查询：NodeID=@NodeID or FirstNodeID=@NodeID（注@NodeID为节点变量）。</li>
		  </ul>
	</div>
  </asp:WizardStep>
  <asp:WizardStep ID="WizardStep4" runat="server" Title="step4">
	<table class="table table-striped table-bordered sys_table">
	  <tr>
		<td class="spacingtitle" align="center" colspan="2">第四步：标签内容</td>
	  </tr>
	  <tr>
		<th class="w12rem_lg">参数[可拖放]</th>
		<td><div id="Div3" class="plist"><asp:Label ID="attlist1" runat="server"></asp:Label></div></td>
	  </tr>
	  <tr>
		<th>判断模式</th>
		<td>  
            <asp:CheckBox ID="BoolMode_Chk" runat="server" Text="判断模式" AutoPostBack="true" OnCheckedChanged="BoolMode_Chk_CheckedChanged"/>
		    <span class="rd_red">[开启后将根据判断条件输出内容]</span>
            <span id="boolMode_sp" runat="server" visible="false">(<span class="rd_red">满足</span>判断)</span>
		</td>
	  </tr>
        <tr id="boolMode_tr" runat="server" visible="false">
            <th>模式设置</th>
            <td>
                <asp:DropDownList ID="Modeltypeinfo" CssClass="form-control text_200_auto" runat="server" AutoPostBack="true">
                    <asp:ListItem Value="计数判断">计数判断</asp:ListItem>
                    <asp:ListItem Value="参数判断">参数判断</asp:ListItem>
                    <asp:ListItem Value="用户登录判断">用户登录判断</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="Valueroot" runat="server" CssClass="form-control text_200_auto" onmousedown="inputtxt(this)" onfocus="inputtxt(this)" placeholder="这里放入标签" />
                <asp:DropDownList ID="bool_addroot_dp" runat="server" CssClass="form-control text_200_auto hidden" Visible="false">
                    <asp:ListItem Value="循环计算">循环计算</asp:ListItem>
                    <asp:ListItem Value="一直累加">一直累加</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="setroot" CssClass="form-control td_m" runat="server">
                    <asp:ListItem Value="大于">大于</asp:ListItem>
                    <asp:ListItem Value="等于" Selected="True">等于</asp:ListItem>
                    <asp:ListItem Value="小于">小于</asp:ListItem>
                    <asp:ListItem Value="不等于">不等于</asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="Modelvalue" class="form-control td_m" runat="server" ToolTip="注意：当判断是否为空时，请不要填写任何内容" />
                <asp:Label ID="Label3" runat="server" ForeColor="#339933" Visible="False" Font-Bold="True" CssClass="hidden"></asp:Label></td>
        </tr>
	  <tr>
		<td class="padding-t0" colspan="2">
        <div id="labeldiv">
        <ul class="nav nav-tabs top_opbar" style="margin-bottom:0px;border-bottom:none;">
            <li class="nav-item"><a class="nav-link active" href="#Tabs0" data-toggle="tab">自定标签</a></li>
            <li class="nav-item"><a class="nav-link" href="#Tabs1" data-toggle="tab">字段标签</a></li>
            <li class="nav-item"><a class="nav-link" href="#Tabs2" data-toggle="tab">系统标签</a></li>
            <li class="nav-item"><a class="nav-link" href="#Tabs3" data-toggle="tab">扩展函数</a></li>
        </ul>
		<div class="row">
        <div class="col-lg-4 col-md-4" style="height:536px;max-width:450px; overflow-y:auto;border:1px solid #ddd;border-right:none;padding:0px;text-align: center;">
            <div class="tab-content">
                <div class="tab-pane active" id="Tabs0" runat="server">
                    <div class="card">
                       <div class="card-header">
                           <asp:DropDownList ID="CustomLabel_DP" runat="server" DataTextField="Name" DataValueField="Name" CssClass="form-control max20rem" onchange="GetCustom(this);"></asp:DropDownList>
                       </div>
                       <div class="panel-body" id="CustomLabel_div" runat="server"></div>
                    </div>
                </div>
                <div class="tab-pane" id="Tabs1">
                    <div class="card card-header">
                       <%-- <div class="panel-heading">
                            <asp:DropDownList ID="Field_DP" runat="server" CssClass="form-control max20rem" onchange="GetField(this);"></asp:DropDownList>
                        </div>--%>
                        <div class="card-body" id="Field_div" runat="server"></div>
                    </div>
                </div>
                <div class="tab-pane" id="Tabs2">
                    <div class="list-group pl-2">
                        <asp:Label ID="lblSys" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="tab-pane" id="Tabs3">
                    <div class="list-group pl-2">
                        <asp:Label ID="lblFun" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-8 col-md-8" style="border:1px solid #ddd;padding:0px;">
              <div style="margin-left:30px;">
                <%=ZoomLa.Safe.SafeC.ReadFileStr("/manage/Template/label.htm") %>
            </div>
            <div id="Textarea">
                <asp:TextBox TextMode="MultiLine" runat="server" ID="textContent" Style="max-width: 100%; width: 100%; height: 530px;" />
            </div>
        </div>
		</div>
    </div>
		</td>
	  </tr>
	  <tr id="bool_s1_tr" runat="server" visible="false">
		<td colspan="2">
            <div><strong>标签内容:(<span class="rd_red">不满足</span>判断)</strong></div>
            <div><span class="rd_red"><b>当选择计数判断时,下面只能填写{Repeate}标签里面的内容</b></span></div>
            <asp:TextBox TextMode="MultiLine" runat="server" ID="falsecontent" Width="100%" Height="231px" onmouseup="dragend4(this)"></asp:TextBox>
		</td><td></td>
	  </tr>
        <tr runat="server" visible="false" data-disuse="true">
            <td align="center" colspan="2">
                <div style="float: left; padding-left: 250px; display: none">
                    <a href="LabelManage.aspx" class="btn btn-primary">返回列表</a>
                    <input type="button" value="保存标签" class="btn btn-primary" onclick="$('#Save_Btn').click();;" />
                </div>
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" ShowSummary="False" />
            </td>
        </tr>
      <tr>
            <td colspan="2">
                <div>
                    <asp:DropDownList ID="Step4_DP" runat="server" CssClass="form-control float-left" Width="120" AutoPostBack="true" OnSelectedIndexChanged="Step_DP_SelectedIndexChanged" onchange="saveEditor();">
                        <asp:ListItem Value="0" Text="基本信息"></asp:ListItem>
                        <asp:ListItem Value="1" Text="数据查询"></asp:ListItem>
                        <asp:ListItem Value="2" Text="参数设定"></asp:ListItem>
                        <asp:ListItem Value="3" Text="标签内容"></asp:ListItem>
                    </asp:DropDownList>
					<div class="float-left">
                    <asp:Button ID="PreviousButtonFinish" runat="server" CausesValidation="False" class="btn btn-outline-info" CommandName="MovePrevious" Text="上一步" OnClick="PreviousButtonStep3_Click" OnClientClick="return saveEditor();" />
                    <input type="button" value="保存标签" class="btn btn-info" onclick="$('#Save_Btn').click();;" />
                    <a href="LabelManage.aspx" class="btn btn-link" onclick="return confirm('要返回列表吗?');"><i class="fa fa-close" aria-hidden="true"></i> 取消</a>
                    <asp:LinkButton OnClick="UseLable_Click" class="btn btn-link" runat="server"><i class="fa fa-copy" aria-hidden="true"> </i> 引用标签</asp:LinkButton></div>
                </div>
            </td>
        </tr>
	</table>
    <div style="margin-top: 5px;">
          <ul class="disc">
              <li>标签内容支持CSS等HTML定义，可以从左侧拖拽标签参数使用。</li>
              <li>重复输出数据请需要在{Repeate}{/Repeate}内进行排序输出。</li>
              <li>扩展函数支持字段格式化、截取、重新筛选、取值获值等操作，使数据输出更加科学合理。</li>
              <li>由于多浏览器兼容与W3C规则严谨度要求，建议标签预览仅作为预览使用，不作为保存操作，以免产生乱码。</li>
          </ul>
      </div>
  </asp:WizardStep>
</WizardSteps>
<StepNavigationTemplate><center></center></StepNavigationTemplate>
<StartNavigationTemplate><center></center></StartNavigationTemplate>
<FinishNavigationTemplate><center></center></FinishNavigationTemplate>
</asp:Wizard>
</ContentTemplate></asp:UpdatePanel>
<div class="hidden">
    <asp:Button runat="server" class="d-none" ID="Save_Btn" OnClick="BtnSave_Click" Text="保存" />
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script src="/Design/JS/sea.js"></script>
<script src="/JS/jquery.validate.min.js"></script> 
<script src="/JS/Controls/ZL_Dialog.js"></script>
<script src="/JS/Controls/ZL_Array.js"></script>
<script src="/Plugins/CodeMirror/LabelCall.js?v=1"></script>
<script>
    //LabelCall调用
    var diag = new ZL_Dialog();
    function opentitle(url, title) {
        diag.url = url;
        diag.title = title;
        diag.ShowModal();
    }
    function closeCuModal() {
        diagLabel.CloseModal();
    }
    //新增Div参数块,拥有绑定功能
    function pdrag(ev) {
        var code = $(ev.target ? ev.target : ev.srcElement).attr("code");
        ev.dataTransfer.setData("Text", code);
    }
    function VoteCheck() {
        var validator = $("#form1").validate({ meta: "validate" });
        return validator.form();
    }
    function changecate(obj) {
        var $text = $("#<%=LabelCate_T.ClientID %>");
        $text.val($(obj).val());
    }
    function saveEditor() {
        $("#textContent").val(editor.getValue());
        return true;
    }
    var base64 = null;
    seajs.use(["base64"], function (instance) { base64 = instance; })
	
	
</script> 
</asp:Content>
