using System;
using System.Data;
using ZoomLa.BLL;
using ZoomLa.SQLDAL;

namespace ZoomLaCMS.Tools
{
    public partial class Example : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            WxAPI api = WxAPI.Code_Get();
            string content = "亲爱的管理员，您的平台有人下单了。\n";
            content += "下单人：徐林之\n";
            content += "时间:"+DateTime.Now.ToString("yyyy/MM/dd HH:mm")+"\n";
            content += "货物:3件\n";
            content += "地址:江西省 南昌市 青山湖区 江大南路\n";
            content += "[<a href='http://a004.2018.z01.com'>点击查看详情</a>]";
            api.SendMsg("oDzZ41XmFr5qnuAdcgJSFFscrCQw", content);
            throw new Exception("发送完成");
        }
    }
}