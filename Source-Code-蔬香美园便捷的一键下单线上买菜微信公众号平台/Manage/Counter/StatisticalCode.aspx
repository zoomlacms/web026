﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatisticalCode.aspx.cs" Inherits="ZoomLaCMS.Manage.Counter.StatisticalCode" MasterPageFile="~/Manage/I/Index.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>统计代码</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <%=Call.SetBread(new Bread[] {
		new Bread("/{manage}/Main.aspx","工作台"),
        new Bread("../Config/SiteInfo.aspx","系统设置 "),
        new Bread("Counter.aspx","访问统计 "),
        new Bread() {url="", text="统计代码",addon="" }}
		)
    %>
	<div class="container-fluid pr-0">
	<div class="row sysRow list_choice">
    <table class="table table-striped table-bordered stati_code sys_table">
        <tr>
            <th class="w12rem_lg">第三方站长统计脚本</th>
            <td>
                <asp:TextBox ID="Code_T" runat="server" CssClass="form-control m50rem_50" TextMode="MultiLine" Height="115"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <th>获取第三方代码</th>
            <td>
                <div class="couter_div"><a title="百度统计" target="_blank" href="http://tongji.baidu.com"><img src="/images/bdidu.png" /></a></div>
                <div class="couter_div"><a title="腾讯分析" target="_blank" href="http://mta.qq.com/"><span class="fa fa-qq"></span></a></div>
                <div class="couter_div"><a title="站长统计" target="_blank" href="http://www.cnzz.com/"><span class="fa fa-line-chart"></span></a></div>
                <div class="couter_div"><a title="我要啦统计" target="_blank" href="http://www.51.la/"><span>51</span></a></div>

            </td>
        </tr>
        <tr>
            <th>引入站内统计</th>
            <td>
               <a href="javascript:;" onclick="AddZLCount();" class="btn btn-outline-info"><i class="fa fa-line-chart"></i> 点击引入</a>
            </td>
        </tr>
        <tr>
            <td></td><td>
                <asp:Button ID="SaveCode_T" OnClick="SaveCode_T_Click" Text="保存" runat="server" CssClass="btn btn-info" /> 
                <button type="button" onclick="$('.codetext').val('')" class="btn btn-outline-info">重置</button>
            </td>
        </tr>
    </table>
	</div></div>
    <style>
        .stati_code .couter_div{float:left;margin-left:20px;}
        .stati_code .couter_div a{line-height:30px;text-decoration:none;}
         .stati_code .couter_div a:hover{text-decoration:none;}
        .stati_code .couter_div span{font-size:30px; font-weight:700;}
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
  <script>
      var code = '<iframe style=\"display:none;\" src=\"/Com/CallCounter\"></iframe>';
      function AddZLCount() {
          var val = $("#Code_T").val();
          val = val.replace(code, "");
          $("#Code_T").val(val + code);
      }
  </script>
</asp:Content>


