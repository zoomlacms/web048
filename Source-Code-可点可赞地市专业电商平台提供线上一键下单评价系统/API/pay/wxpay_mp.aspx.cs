using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using ZoomLa.Common;
using System.Xml;
using ZoomLa.BLL;
using ZoomLa.Model;
using Newtonsoft.Json;
using System.Web.Security;
using ZoomLa.Components;
using ZoomLa.Model.Plat;
using ZoomLa.BLL.Plat;
using Newtonsoft.Json.Linq;
using System.Net;
using System.Text;
using ZoomLa.BLL.WxPayAPI;
//公众号支付,必须在微信浏览器内,通过JS API完成支付申请
public partial class API_pay_wxpay_mp : System.Web.UI.Page
{
    B_User buser = null;
    public string timestr = "";
    public string nonce_str = "";
    public string prepay_id = "";
    public string paySign = "";
    public string nonceStr = "5K8264ILTKCH16CQ2502SI8ZNMTM67VS";
    string notifyUrl = SiteConfig.SiteInfo.SiteUrl + "/payonline/return/WxPayReturn.aspx";

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            try
            {
                TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
                timestr = Convert.ToInt64(ts.TotalSeconds).ToString();
                WeiXinPay();
                string stringA = "appId=" + WxPayConfig.APPID + "&nonceStr=" + nonceStr + "&package=prepay_id=" + prepay_id + "&signType=MD5&timeStamp=" + timestr;
                string stringSignTemp = stringA + "&key=hx008zoomlacn1thzhenchenwafywnff";
                paySign = StringHelper.MD5(stringSignTemp).ToUpper();

            }
            catch (Exception ex) { Remind_L.Text = ex.Message; }
        }
    }
    public void WeiXinPay()
    {
        WxAPI api = WxAPI.Code_Get();//输入指的公众账号ID,如不指定,则默认取第一个
        string code = Request.QueryString["code"];
        string resultStr = APIHelper.GetWebResult("https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + api.AppId.APPID + "&secret=" + api.AppId.Secret + "&code=" + code + "&grant_type=authorization_code");
        JObject obj = (JObject)JsonConvert.DeserializeObject(resultStr);

        WxPayData wxdata = new WxPayData();
        wxdata.SetValue("out_trade_no", timestr);
        wxdata.SetValue("body", "支付测试");
        wxdata.SetValue("total_fee", 1);
        wxdata.SetValue("trade_type", "JSAPI");
        wxdata.SetValue("notify_url", notifyUrl);
        wxdata.SetValue("product_id", "1212122121");//必填
        wxdata.SetValue("openid", obj["openid"].ToString());//公众号支付必填
        wxdata.SetValue("nonce_str", nonceStr);

        WxPayData result = WxPayApi.UnifiedOrder(wxdata);
        if (result.GetValue("return_code").ToString().Equals("FAIL")){ function.WriteErrMsg("商户" + result.GetValue("return_msg")); }
        prepay_id = result.GetValue("prepay_id").ToString();
    }
    public WxPayData UnifiedOrder(WxPayData inputObj, int timeOut = 6)
    {
        string url = "https://api.mch.weixin.qq.com/pay/unifiedorder";
        //检测必填参数
        if (!inputObj.IsSet("out_trade_no"))
        {
            throw new WxPayException("缺少统一支付接口必填参数out_trade_no！");
        }
        else if (!inputObj.IsSet("body"))
        {
            throw new WxPayException("缺少统一支付接口必填参数body！");
        }
        else if (!inputObj.IsSet("total_fee"))
        {
            throw new WxPayException("缺少统一支付接口必填参数total_fee！");
        }
        else if (!inputObj.IsSet("trade_type"))
        {
            throw new WxPayException("缺少统一支付接口必填参数trade_type！");
        }

        //关联参数
        if (inputObj.GetValue("trade_type").ToString() == "JSAPI" && !inputObj.IsSet("openid"))
        {
            throw new WxPayException("统一支付接口中，缺少必填参数openid！trade_type为JSAPI时，openid为必填参数！");
        }
        if (inputObj.GetValue("trade_type").ToString() == "NATIVE" && !inputObj.IsSet("product_id"))
        {
            throw new WxPayException("统一支付接口中，缺少必填参数product_id！trade_type为JSAPI时，product_id为必填参数！");
        }
        if (!inputObj.IsSet("notify_url"))//使用PC端的回调
        {
            throw new WxPayException("notify_url,的值不能为空");
        }

        inputObj.SetValue("appid", WxPayConfig.APPID);//公众帐号ID
        inputObj.SetValue("mch_id", WxPayConfig.MCHID);//商户号
        inputObj.SetValue("spbill_create_ip", "");//终端ip	  	    
        inputObj.SetValue("nonce_str", nonceStr);
        //签名
        inputObj.SetValue("sign", inputObj.MakeSign());
        string xml = inputObj.ToXml();

        var start = DateTime.Now;
        string response = HttpService.Post(xml, url, false, timeOut);
        var end = DateTime.Now;
        int timeCost = (int)((end - start).TotalMilliseconds);

        WxPayData result = new WxPayData();
        result.FromXml(response);
        //ReportCostTime(url, timeCost, result);//测速上报
        return result;
    }
}