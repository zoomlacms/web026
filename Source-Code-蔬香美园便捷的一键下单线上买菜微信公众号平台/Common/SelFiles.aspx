<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelFiles.aspx.cs" Inherits="ZoomLaCMS.Common.SelFiles" MasterPageFile="~/Common/Master/Empty.master" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>选择文件</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div class="container-fluid">
        <div class="input-group">
            <asp:TextBox ID="ImgName_T" runat="server" CssClass="form-control" placeholder="文件名"></asp:TextBox>
            <asp:TextBox ID="Sdate_T" runat="server" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd' });" class="form-control" placeholder="开始日期" />
            <asp:TextBox ID="Edate_T" runat="server" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd' });" class="form-control" placeholder="结束日期" />
            <div class="input-group-append">

                <asp:Button ID="Search_B" CssClass="btn btn-info" runat="server" OnClick="Search_B_Click" Text="搜索"></asp:Button>
<%--                <button class="btn btn-info" type="button" onclick="$('#FileUp_F').click()">上传文件</button>
                <ZL:FileUpload ID="FileUp_F" runat="server" Style="display: none;" />
                <asp:Button ID="FIleUp_B" OnClick="FIleUp_B_Click" runat="server" Style="display: none;" />
                <button type="button" onclick="window.location = location;" class="btn btn-info">刷新</button>--%>
            </div>
        </div>
        <div style="border-top:1px solid #ddd;border-bottom:1px solid #ddd; margin-top:5px;padding-top:5px;">
            <div class="panel-body">
                <ul class="list-unstyled margin_t5" style="height:470px; overflow-y: auto;" runat="server" id="file_ul">
                    <ZL:ExRepeater ID="File_RPT" runat="server" PageSize="12" PagePre="<div class='clearfix'></div><div class='text-center'>" PageEnd="</div>">
                        <ItemTemplate>
                            <li style="width:24%;padding:3px;">
                                <div><%#GetFileInfo() %></div>
                                <div class="text-right">
                                    <label><input type="checkbox" name="img_list" value="<%#GetVpath() %>" style="width:25px;height:25px;margin-top:3px;"/></label></div>
                            </li>
                        </ItemTemplate>
                        <FooterTemplate></FooterTemplate>
                    </ZL:ExRepeater>
                </ul>
                <div runat="server" id="empty_tip" class="text-center">
                    <i class="fa fa-dropbox" style="font-size:10rem;color:#ddd;"></i>
                    <div style="font-size:18px;color:#ddd;">尚未上传图片文件</div>
                </div>
            </div>
         </div>
    </div>
    <div class="Conent_fix" style="margin-top:5px;text-align:center;">
        <button type="button" onclick="SelFileData()" class="btn btn-primary">确定选择</button>
        <button type="button" onclick="closeDiag()" class="btn btn-primary">关闭窗口</button>
    </div>
    <asp:HiddenField runat="server" ID="PVal_Hid" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
<style>
.fileimg{display:block;width:100%;height:50px;text-align:center;font-size:3em;}
.fileimg img{height:50px; vertical-align:top;}
.fileflod{line-height:50px;}
.headtip{padding:5px;}
.list-unstyled img{width:150px;height:100px;}
.list-unstyled li{text-align:center;float:left;}
</style>
<script src="/JS/ICMS/ZL_Common.js"></script>
<script src="/JS/DatePicker/WdatePicker.js"></script>
<script>
    function ShowUpFile(url) {
        parent.PageCallBack('selfiles', url, pval);
    }
    var pval = JSON.parse($("#PVal_Hid").val());
    function closeDiag() {
        if (parent) {
            if (parent.CloseComDiag) { parent.CloseComDiag(); }
            if (parent.CloseDiag) { parent.CloseDiag(); }
        }
    }
    function SelFileData() {
        var $chk = $("[name=img_list]:checked")//选中数组对象
        if ($chk.length > 0) {
            var imgurl = "";
            for (var i = 0; i < $chk.length; i++) {
                imgurl += $chk[i].value + "|";
            }
            parent.PageCallBack('selfiles', imgurl, pval);//父页面方法 name 控件id, 数组对象,上传根目录
        }
    }
    $().ready(function () {
        $("#FileUp_F").change(function () {
            $("#FIleUp_B").click();
        });
    });

</script>
</asp:Content>
