using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZoomLa.BLL;
using ZoomLa.BLL.API;
using ZoomLa.Common;
using ZoomLa.SQLDAL;

namespace ZoomLaCMS.Cart
{
  
    public partial class CartByClass : System.Web.UI.Page
    {
        public string nodeJson = "", cartJson = "",productJson;
        B_Node nodeBll = new B_Node();
        B_Cart cartBll = new B_Cart();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (function.isAjax())
            //{
            //    M_APIResult retMod = new M_APIResult(M_APIResult.Failed);
            //    string action = Request["action"];
            //    switch (action)
            //    {
            //        case "product_list":
            //            {
            //                int nid = DataConvert.CLng(Request["nid"]);
            //                string where = "NodeID IN (SELECT NodeID FROM ZL_Node WHERE ParentID=" + nid + " OR NodeID="+nid+") AND Proclass=1";
            //                DataTable dt = DBCenter.SelWithField("ZL_Commodities", "ID,Proname,LinPrice,ProUnit,[Weight],Thumbnails",where,"NodeID ASC,AddTime DESC");
            //                retMod.result = JsonConvert.SerializeObject(dt);
            //                retMod.retcode = M_APIResult.Success;
            //            }
            //            break;
            //        default:
            //            retMod.retmsg = "action不存在";
            //            break;
            //    }
            //    Response.Clear();
            //    Response.Write(retMod.ToString());Response.Flush();Response.End();
            //}
            if (!IsPostBack)
            {
                DataTable nodeDT = SelProNodes();
                DataTable cartDT = cartBll.SelByCookID(B_Cart.GetCartID(Context), 1);
                DataTable productDT = SelProduct();
                nodeJson = JsonConvert.SerializeObject(nodeDT);
                cartJson = JsonConvert.SerializeObject(cartDT);
                productJson = JsonConvert.SerializeObject(productDT);
            }
        }
        private DataTable SelProduct()
        {
            string where = "Proclass=1";
            DataTable dt = DBCenter.SelWithField("ZL_Commodities", "ID,NodeID,Proname,LinPrice,ProUnit,[Weight],Thumbnails", where, "NodeID ASC,AddTime DESC");
            return dt;
        }
        private DataTable SelProNodes()
        {
            string where = "NodeType=1 AND (NodeListType=2 OR NodeListType=3) AND NodeID!=2";
            return DBCenter.SelWithField("ZL_Node","NodeID,ParentID,NodeName",where);
        }
    }
}