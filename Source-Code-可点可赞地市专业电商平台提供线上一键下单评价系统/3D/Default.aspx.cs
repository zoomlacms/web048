using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using ZoomLa.BLL;
using ZoomLa.Common;

public partial class test2_3d_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            btnCharge_Click();
        }
    }
    //缴费
    private void btnCharge_Click()
    {
        //先用IRechargeList_WEC_test测试，暂时先不要用IRechargeList_WEC，它会真实缴费的
        string m_APIUrl = "http://lifeapi.salerwise.com/IWEC";
        string sign = "1475c4afa9b9f42b7c8b3913fc54df85";//2013-08-17 32位md5加密
        string usernumber = "7000616";
        string inordernumber = "IWEC" + usernumber + DateTime.Now.ToString("yyyyMMddHHmmss") + "0001";
        string outordernumber = "none";
        string proid = "1080";
        string account = "0016773758";
        int paymoney = 7430;
        string yearmonth = "";
        string starttime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        int timeout = 500;
        string attr1 = "";
        string attr2 = "";
        string recordkey = MD5Make(usernumber + inordernumber + outordernumber + proid + account + paymoney + yearmonth + starttime + timeout + attr1 + attr2, sign); //ESaiPay.Common.DEncrypt.DESEncrypt.ESaiAes(usernumber + inordernumber + outordernumber + proid + account + paymoney + yearmonth + starttime + timeout + attr1 + attr2 + sign);

        //string url = m_APIUrl+"/IRechargeList_WEC";
        string url = m_APIUrl + "/IRechargeList_WEC";
        IDictionary<string, string> Parem = new Dictionary<string, string>();
        Parem.Add("UserNumber", usernumber);
        Parem.Add("InOrderNumber", inordernumber);
        Parem.Add("OutOrderNumber", outordernumber);
        Parem.Add("ProId", proid);
        Parem.Add("Account", account);
        Parem.Add("PayMoney", paymoney.ToString());
        Parem.Add("YearMonth", yearmonth);
        Parem.Add("StartTime", starttime);
        Parem.Add("TimeOut", timeout.ToString());
        Parem.Add("Attr1", attr1);
        Parem.Add("Attr2", attr2);
        Parem.Add("RecordKey", recordkey);
        Parem.Add("Remark", "");
        Esai.Api.Util.WebUtils utilBLL = new Esai.Api.Util.WebUtils();
        string result = utilBLL.DoPost(url, Parem);
        function.WriteErrMsg(result);
    }

    //订单查询

    //加密
    private string MD5Make(string Info, string Sign)
    {
        string retStr;
        System.Security.Cryptography.MD5CryptoServiceProvider m5 = new System.Security.Cryptography.MD5CryptoServiceProvider();
        //创建md5对象
        byte[] inputBye;
        byte[] outputBye;
        inputBye = Encoding.GetEncoding("GB2312").GetBytes(Info + Sign);
        outputBye = m5.ComputeHash(inputBye);
        retStr = System.BitConverter.ToString(outputBye);
        retStr = retStr.Replace("-", "").ToUpper();
        return retStr.Substring(0, 16);
    }
}
namespace Esai.Api.Util
{

    /// <summary>
    /// 网络工具类。
    /// </summary>
    public sealed class WebUtils
    {
        private int _timeout = 100000;
        /** 查询申请应答参数 **/
        protected static Hashtable esaipayQueryparameters = new Hashtable();

        /// <summary>
        /// 请求与响应的超时时间
        /// </summary>
        public int Timeout
        {
            get { return this._timeout; }
            set { this._timeout = value; }
        }
        /** 获取参数值 */
        public static string getParameter(string parameter)
        {

            string s = (string)esaipayQueryparameters[parameter];
            return (null == s) ? "" : s;
        }

        /** 设置参数值 */
        public static void setParameter(string parameter, string parameterValue)
        {
            esaipayQueryparameters = new Hashtable();
            if (parameter != null && parameter != "")
            {
                if (esaipayQueryparameters.Contains(parameter))
                {
                    esaipayQueryparameters.Remove(parameter);
                }

                esaipayQueryparameters.Add(parameter, parameterValue);
            }
        }

        #region 获取查询结果参数
        /** 获取参数值 */
        public static string getQueryParameter(string parameter)
        {
            string s = (string)esaipayQueryparameters[parameter];
            return (null == s) ? "" : s;
        }

        /** 设置参数值 */
        public static void setQueryParameter(string parameter, string parameterValue)
        {
            if (parameter != null && parameter != "")
            {
                if (esaipayQueryparameters.Contains(parameter))
                {
                    esaipayQueryparameters.Remove(parameter);
                }

                esaipayQueryparameters.Add(parameter, parameterValue);
            }
        }
        #endregion
        /// <summary>
        /// Base64解码
        /// </summary>
        /// <param name="Message"></param>
        /// <returns></returns>
        public static string Base64Decode(string Message)
        {
            if ((Message.Length % 4) != 0)
            {
                throw new ArgumentException("不是正确的BASE64编码，请检查。", "Message");
            }
            if (!System.Text.RegularExpressions.Regex.IsMatch(Message, "^[A-Z0-9/+=]*$", System.Text.RegularExpressions.RegexOptions.IgnoreCase))
            {
                throw new ArgumentException("包含不正确的BASE64编码，请检查。", "Message");
            }
            string Base64Code = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
            int page = Message.Length / 4;
            System.Collections.ArrayList outMessage = new System.Collections.ArrayList(page * 3);
            char[] message = Message.ToCharArray();
            for (int i = 0; i < page; i++)
            {
                byte[] instr = new byte[4];
                instr[0] = (byte)Base64Code.IndexOf(message[i * 4]);
                instr[1] = (byte)Base64Code.IndexOf(message[i * 4 + 1]);
                instr[2] = (byte)Base64Code.IndexOf(message[i * 4 + 2]);
                instr[3] = (byte)Base64Code.IndexOf(message[i * 4 + 3]);
                byte[] outstr = new byte[3];
                outstr[0] = (byte)((instr[0] << 2) ^ ((instr[1] & 0x30) >> 4));
                if (instr[2] != 64)
                {
                    outstr[1] = (byte)((instr[1] << 4) ^ ((instr[2] & 0x3c) >> 2));
                }
                else
                {
                    outstr[2] = 0;
                }
                if (instr[3] != 64)
                {
                    outstr[2] = (byte)((instr[2] << 6) ^ instr[3]);
                }
                else
                {
                    outstr[2] = 0;
                }
                outMessage.Add(outstr[0]);
                if (outstr[1] != 0)
                    outMessage.Add(outstr[1]);
                if (outstr[2] != 0)
                    outMessage.Add(outstr[2]);
            }
            byte[] outbyte = (byte[])outMessage.ToArray(Type.GetType("System.Byte"));
            return System.Text.Encoding.Default.GetString(outbyte);
        }
        /// <summary>
        /// 执行post请求
        /// </summary>
        /// <param name="Parameter"></param>
        /// <param name="timeout"></param>
        /// <param name="input_charset"></param>
        /// <param name="floorkey"></param>
        /// <returns></returns>
        public static string ToPost(string Parameter, int timeout, string input_charset, string floorkey)
        {
            string flg = "";
            try
            {
                #region 设置接口参数
                /*充值申请接口*/
                string esaiPayInterfaceUrl = "http://10.0.0.153:8080/Order/TaoBaoOpen";
                string valpairs = Parameter;
                UTF8Encoding encoding = new UTF8Encoding();
                byte[] b = encoding.GetBytes(valpairs);
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(esaiPayInterfaceUrl);
                request.Timeout = timeout;
                request.Method = "POST";
                request.ContentType = "application/x-www-form-urlencoded";
                request.ContentLength = b.Length;
                request.Proxy = WebProxy.GetDefaultProxy();
                request.Proxy.Credentials = CredentialCache.DefaultCredentials;
                System.IO.Stream sw = request.GetRequestStream();
                sw.Write(b, 0, b.Length);
                sw.Close();
                #endregion
                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                {
                    if (response.StatusCode == HttpStatusCode.OK)
                    {
                        Stream resStream = response.GetResponseStream();
                        System.IO.StreamReader streamReader = new StreamReader(resStream, System.Text.Encoding.GetEncoding("UTF-8"));
                        string content = streamReader.ReadToEnd();
                        //textBox1.Text = content; 
                        streamReader.Close();
                        resStream.Close();

                        #region 处理返回参数
                        esaipayQueryparameters = new Hashtable();//初始化哈希
                        XmlDocument xmlDoc = new XmlDocument();
                        xmlDoc.LoadXml(content);
                        //<?xml version='1.0' encoding='GB2312'?><newesaipay><orderStatus>error</orderStatus><returnInfo >非法用户</returnInfo ><timeStamp >2012-07-25 14:18:51</timeStamp ></newesaipay>
                        XmlNode root = xmlDoc.SelectSingleNode("newesaipay");
                        XmlNodeList xnl = root.ChildNodes;
                        foreach (XmlNode xnf in xnl)
                        {
                            setQueryParameter(xnf.Name, xnf.InnerXml);
                        }
                        #endregion

                        #region 在这里处理查询返回结果

                        string result = getQueryParameter("orderStatus");//返回处理结果详见文档枚举
                        string msg = getQueryParameter("returnInfo");
                        string time = getQueryParameter("timeStamp");


                        if (result.Equals("success"))
                        {
                            flg = msg;

                            //根据自己公司内部业务进行处理
                            //txtfundmsg.Text = content;
                        }
                        else
                        {

                            flg = msg;

                            //根据自己公司内部业务进行处理
                            // txtfundmsg.Text = content;
                        }
                        #endregion

                    }

                    return flg;
                }

            }
            catch (Exception err)
            {

                return err.Message.ToString();


            }


        }
        /// <summary>
        /// 执行HTTP POST请求。
        /// </summary>
        /// <param name="url">请求地址</param>
        /// <param name="parameters">请求参数</param>
        /// <returns>HTTP响应</returns>
        public string DoPost(string url, IDictionary<string, string> parameters)
        {
            try
            {
                HttpWebRequest req = GetWebRequest(url, "POST");
                req.ContentType = "application/x-www-form-urlencoded;charset=utf-8";

                byte[] postData = Encoding.UTF8.GetBytes(BuildQuery(parameters, "utf8"));
                System.IO.Stream reqStream = req.GetRequestStream();
                reqStream.Write(postData, 0, postData.Length);
                reqStream.Close();

                HttpWebResponse rsp = (HttpWebResponse)req.GetResponse();
                Encoding encoding = Encoding.GetEncoding(rsp.CharacterSet);
                return GetResponseAsString(rsp, encoding);
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        /// <summary>
        /// 执行HTTP GET请求。
        /// </summary>
        /// <param name="url">请求地址</param>
        /// <param name="parameters">请求参数</param>
        /// <returns>HTTP响应</returns>
        public string DoGet(string url, IDictionary<string, string> parameters)
        {
            if (parameters != null && parameters.Count > 0)
            {
                if (url.Contains("?"))
                {
                    url = url + "&" + BuildQuery(parameters, "utf8");
                }
                else
                {
                    url = url + "?" + BuildQuery(parameters, "utf8");
                }
            }

            HttpWebRequest req = GetWebRequest(url, "GET");
            req.ContentType = "application/x-www-form-urlencoded;charset=utf-8";

            HttpWebResponse rsp = (HttpWebResponse)req.GetResponse();
            Encoding encoding = Encoding.GetEncoding(rsp.CharacterSet);
            return GetResponseAsString(rsp, encoding);
        }


        public bool CheckValidationResult(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors errors)
        { //直接确认，否则打不开
            return true;
        }

        public HttpWebRequest GetWebRequest(string url, string method)
        {
            HttpWebRequest req = null;
            if (url.Contains("https"))
            {
                ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(CheckValidationResult);
                req = (HttpWebRequest)WebRequest.CreateDefault(new Uri(url));
            }
            else
            {
                req = (HttpWebRequest)WebRequest.Create(url);
            }

            req.ServicePoint.Expect100Continue = false;
            req.Method = method;
            req.KeepAlive = true;
            req.UserAgent = "Top4Net";
            req.Timeout = this._timeout;

            return req;
        }

        /// <summary>
        /// 把响应流转换为文本。
        /// </summary>
        /// <param name="rsp">响应流对象</param>
        /// <param name="encoding">编码方式</param>
        /// <returns>响应文本</returns>
        public string GetResponseAsString(HttpWebResponse rsp, Encoding encoding)
        {
            System.IO.Stream stream = null;
            StreamReader reader = null;

            try
            {
                // 以字符流的方式读取HTTP响应
                stream = rsp.GetResponseStream();
                reader = new StreamReader(stream, encoding);
                return reader.ReadToEnd();
            }
            finally
            {
                // 释放资源
                if (reader != null) reader.Close();
                if (stream != null) stream.Close();
                if (rsp != null) rsp.Close();
            }
        }

        /// <summary>
        /// 组装GET请求URL。
        /// </summary>
        /// <param name="url">请求地址</param>
        /// <param name="parameters">请求参数</param>
        /// <returns>带参数的GET请求URL</returns>
        public string BuildGetUrl(string url, IDictionary<string, string> parameters)
        {
            if (parameters != null && parameters.Count > 0)
            {
                if (url.Contains("?"))
                {
                    url = url + "&" + BuildQuery(parameters, "utf8");
                }
                else
                {
                    url = url + "?" + BuildQuery(parameters, "utf8");
                }
            }
            return url;
        }
        /// <summary>
        /// 验证时间戳验证
        /// </summary>
        /// <param name="Time"></param>
        /// <returns></returns>
        public static bool ValiTime(string Time)
        {
            bool pass = true;
            try
            {
                DateTime Valitime = Convert.ToDateTime(Time);
                System.TimeSpan ND = DateTime.Now - Valitime;
                int minutes = ND.Seconds;//时间差/分钟
                int hour = ND.Hours;//时间差/小时
                if (DateTime.Now > Valitime.AddMinutes(120))//时间戳效验 设定120分钟
                {
                    pass = false;
                }
            }
            catch (Exception)
            {
                pass = false;
            }
            return pass;
        }
        /// <summary>
        /// 组装普通文本请求参数。
        /// </summary>
        /// <param name="parameters">Key-Value形式请求参数字典</param>
        /// <returns>URL编码后的请求数据</returns>
        public static string BuildQuery(IDictionary<string, string> parameters, string encode)
        {
            StringBuilder postData = new StringBuilder();
            bool hasParam = false;

            IEnumerator<KeyValuePair<string, string>> dem = parameters.GetEnumerator();
            while (dem.MoveNext())
            {
                string name = dem.Current.Key;
                string value = dem.Current.Value;
                // 忽略参数名或参数值为空的参数
                if (!string.IsNullOrEmpty(name))//&& !string.IsNullOrEmpty(value)
                {
                    if (hasParam)
                    {
                        postData.Append("&");
                    }

                    postData.Append(name);
                    postData.Append("=");
                    if (encode == "gb2312")
                    {
                        postData.Append(HttpUtility.UrlEncode(value, Encoding.GetEncoding("gb2312")));
                    }
                    else if (encode == "utf8")
                    {
                        postData.Append(HttpUtility.UrlEncode(value, Encoding.UTF8));
                    }
                    else
                    {
                        postData.Append(value);
                    }
                    hasParam = true;
                }
            }

            return postData.ToString();
        }
    }
}
