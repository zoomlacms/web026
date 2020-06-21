using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.Model;
using ZoomLa.Common;
using Newtonsoft.Json;
using ZoomLa.Components;
using System.Data;
using ZoomLa.SQLDAL;
using System.Data.SqlClient;

namespace ZoomLaCMS.Manage.WeiXin
{
    public partial class WxUserList : System.Web.UI.Page
    {
        WxAPI api = null;
        B_WX_APPID appBll = new B_WX_APPID();
        B_WX_User wxuserBll = new B_WX_User();
        public int AppId { get { return DataConverter.CLng(Request.QueryString["appid"]); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            try { api = WxAPI.Code_Get(AppId); } catch { }
            if (function.isAjax())
            {
                string action = Request.Form["action"]; string result = "";
                switch (action)
                {
                    case "update":
                        M_WX_User oldmod = wxuserBll.SelForOpenid(Request.Form["openid"]);
                        if (oldmod != null && oldmod.ID > 0)
                        {
                            M_WX_User usermod = api.GetWxUserModel(Request.Form["openid"]);
                            usermod.ID = oldmod.ID;
                            usermod.CDate = DateTime.Now;
                            usermod.AppId = AppId;
                            wxuserBll.UpdateByID(usermod);
                            result = JsonConvert.SerializeObject(usermod);
                        }
                        else
                            result = "-1";
                        break;
                    default:
                        break;
                }
                Response.Write(result); Response.Flush(); Response.End();
            }
            if (!IsPostBack)
            {
                B_ARoleAuth.AuthCheckEx(ZLEnum.Auth.portable, "wechat");
                MyBind();
            }
        }
        public void MyBind()
        {
            DataTable dt = wxuserBll.SelByAppId(AppId, Key_T.Text);
            //if (dt.Rows.Count <= 0)
            //{
            //    dt = GetUserList();//从微信平台获取关注者
            //    dt.DefaultView.RowFilter = "Name LIKE '%" + name + "%'";
            //}
            //dt.DefaultView.Sort = "ID DESC";
            EGV.DataSource = dt;
            EGV.DataBind();
            M_WX_APPID appmod = appBll.SelReturnModel(AppId);
            Alias_L.Text = " [公众号:" + appmod.Alias + "]";
        }
        public DataTable GetUserList()
        {
            List<M_WX_User> users = api.SelAllUser();
            foreach (var item in users)
            {
                item.CDate = DateTime.Now;
                item.AppId = AppId;
                wxuserBll.Insert(item);
            }
            return wxuserBll.SelByAppId(AppId);
        }
        protected void EGV_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            EGV.PageIndex = e.NewPageIndex;
            MyBind();
        }
        public string GetSexIcon()
        {
            string classname = DataConverter.CLng(Eval("Sex")) == 1 ? "fa fa-male" : "fa fa-female";
            return "<span style='font-size:20px;' class='" + classname + " sex'></span>";
        }
        public string GetUserGroup()
        {
            switch (DataConverter.CLng(Eval("Groupid")))
            {
                case 0:
                    return "未分组";
                case 1:
                    return "黑名单";
                case 2:
                    return "星标组";
                default:
                    return "";
            }
        }
        protected void Search_B_Click(object sender, EventArgs e)
        {
            MyBind();
        }
        protected void SetManager_Btn_Click(object sender, EventArgs e)
        {
            int ztype = DataConvert.CLng((sender as Button).CommandArgument);
            string ids = Request.Form["idchk"];
            if (!string.IsNullOrEmpty(ids))
            {
                SafeSC.CheckIDSEx(ids);
                DBCenter.UpdateSQL(wxuserBll.TbName, "ZType=" + ztype, "ID IN (" + ids + ")");
            }
            function.WriteSuccessMsg("操作成功");
        }
        public string ShowZType()
        {
            int ztype = DataConvert.CLng(Eval("ZType"));
            switch (ztype)
            {
                case 1:
                    return "<span style='color:green;'>管理员</span>";
                default:
                    return "";
            }
        }
    }
}