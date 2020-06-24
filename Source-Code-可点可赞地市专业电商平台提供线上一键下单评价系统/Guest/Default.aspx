﻿<%@ page language="C#" autoeventwireup="true" validaterequest="false" inherits="BBS_leaveword, App_Web_2j5ndc2w" masterpagefile="~/Common/Master/Empty.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/Plugins/Ueditor/ueditor.all.min.js"></script>
    <link href="/App_Themes/Guest.css" rel="stylesheet" type="text/css" />
    <title>留言中心首页</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <div id="ask_top">
        <div class="container">
            <div class="row">
                <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12">
                    <div class="ask_top_l">
                        <ul class="list-inline">
                            <li><a onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('{$SiteURL/}');" href="javascript:;">设为首页</a></li>
                            <li><a href="javascript:;" type="button" id="dropdownMenu1" data-toggle="dropdown">官网频道<span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                                    <%Call.Label("{ZL.Label id=\"输出根节点下一级栏目列表\" ShowNum=\"8\" /}");%>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
                    <div class="ask_top_r">
                        <ul class="list-inline">
                            <li><i class="fa fa-graduation-cap"></i><a href="/Baike">百科</a></li>
                            <li><i class="fa fa-envelope"></i><a href="/Guest">留言</a></li>
                            <li><i class="fa fa-question-circle"></i><a href="/Ask">问答</a></li>
                            <li><i class="fa fa-paw"></i><a href="/Index">贴吧</a></li>
                            <li style="<%=getstyle()%>">
                                <div class="dropdown">
                                    <a id="dLabel" data-target="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <asp:Label runat="server" ID="user"></asp:Label>
                                    </a><span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/" target="_blank">我的空间</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/" target="_blank">我的帖子</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/Content/MyFavori.aspx" target="_blank">我的喜欢</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/" target="_blank">我的关注</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/" target="_blank">我的投票</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="/User/Info/UserBase.aspx" target="_blank">个人设置</a></li>
                    <li role="presentation"><a role="menuitem" tabindex="-1" href="/user/Logout.aspx">安全退出</a></li>
                </ul>
                                </div>
                            </li>
                            <li style="<%=getstyles()%>"><a href="/User/Login.aspx?ReturnUrl=/guest/" target="_blank">登录</a>|<a href="/User/Register.aspx?ReturnUrl=/Guest/" target="_blank">注册</a></li>
                        </ul>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12 ask_logo">
            <a href="/Guest/Ask/Default.aspx">
                <img src='<%Call.Label("{$LogoUrl/}"); %>' alt="<%Call.Label("{$SiteName/}"); %>留言系统" /></a>
        </div>
        <div class="col-lg-7 col-md-7 col-sm-7 col-xs-12 padding0">
            <div class="padding10" style="margin-top: 25px;">
                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12"></div>
                <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 padding0">
                    <asp:DropDownList ID="Gtype" runat="server" CssClass="form-control">
                        <asp:ListItem>留言标题</asp:ListItem>
                        <asp:ListItem>留言ID</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-lg-5 col-md-5 col-sm-5 col-xs-12 padding0">
                    <div class="input-group">
                        <asp:TextBox runat="server" ID="txtName" onmouseover="this.focus()" autocomplete="off" class="form-control" TabIndex="1"></asp:TextBox>
                        <span class="input-group-btn">
                            <asp:Button ID="Search_B" runat="server" Text="搜索" UseSubmitBehavior="false" CausesValidation="False" class="btn btn-primary" />
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="position: relative;">
        <div class="navbar navbar-default navbar-static-top" role="navigation" id="guest_nav">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"><span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button>
                    <a class="navbar-brand" href="/Guest/Default.aspx">留言反馈</a>
                </div>
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li id="lmenu0"><a href="Default.aspx" title="留言首页">留言首页</a></li>
                        <asp:Repeater ID="Repeater1" runat="server">
                            <ItemTemplate><%#GetDataItem()%> </ItemTemplate>
                        </asp:Repeater>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <ol class="breadcrumb">
            <li>您的位置：<a href="/">网站首页</a></li>
            <li><a href="Default.aspx">留言中心</a></li>
            <li><a href="#GuestBorder">留言板</a></li>
            <li class="active">
                <asp:Literal ID="LitCate" runat="server"></asp:Literal>
            </li>
        </ol>
    </div>
    <div class="container">
        <table class="table table-striped table-bordered table-hover" style="margin-bottom: 3px;">
            <tr>
                <td>标题</td>
                <td>类别</td>
                <td>时间</td>
            </tr>
            <ZL:Repeater runat="server" ID="RPT" EnableTheming="false">
                <ItemTemplate>
                    <tr>
                        <td><a href="GuestShow.aspx?GID=<%# Eval("GID")%>"><%# GetTitle()%></a></td>
                        <td><a href="Default.aspx?CateID=<%# Eval("CateID","{0}")%>"><%# GetCate(Eval("CateID","{0}")) %></a></td>
                        <td><%#Eval("GDate", "{0:yyyy-MM-dd hh:mm}")%></td>
                    </tr>
                </ItemTemplate>
            </ZL:Repeater>
        </table>
        <asp:Literal ID="Page_Lit" runat="server"></asp:Literal>
    </div>
    <div class="container">
        <div id="banAnony" class="alert alert-danger" role="alert" runat="server" visible="false">你好请先登录，再发布留言!<a href="/user/Login.aspx?ReturnUrl=/guest/" style="color: #133db6;">[点击登录]</a></div>
        <div id="userDiv" runat="server">
            <table class="table table-bordered" style="margin-top: 10px;">
                <tbody id="UCate" runat="server" style="display: none">
                    <tr>
                        <td align="right" style="vertical-align: middle;"><strong>选择分类：</strong>
                            <div id="divshap" style="display: none" runat="server"><strong>该留言需要先登录才能发表，您尚未登录，请先</strong><a href="/User/Login.aspx?ReturnUrl=/Guest/" style="font-size: 20px; color: blue;">登录</a></div>
                        </td>
                        <td>
                            <asp:DropDownList ID="DDLCate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DDLCate_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList></td>
                    </tr>
                </tbody>
                <tbody id="TCateName" runat="server" style="display: none">
                    <tr>
                        <td class="td_m"><strong>分类：</strong></td>
                        <td>
                            <asp:Label ID="LblCateName" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                </tbody>
                <tr>
                    <td><strong>标题：</strong></td>
                    <td>
                        <asp:TextBox ID="TxtTTitle" runat="server" MaxLength="100" class="form-control" />
                        <asp:RequiredFieldValidator ID="TxtTTitleValidator" runat="server" ControlToValidate="TxtTTitle" ErrorMessage="标题不能为空!" SetFocusOnError="True" Display="Dynamic" />
                        <span id="RequiredFieldValidator2"></span></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea runat="server" id="TxtTContent" style="height: 300px; width: 100%;"></textarea>
                        <%=Call.GetUEditor("TxtTContent") %> <span id="RequiredFieldValidator1"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right" style="vertical-align: middle;"><strong>验证码：</strong></td>
                    <td>
                        <asp:TextBox ID="VCode" MaxLength="6" runat="server" CssClass="form-control" Width="100" Style="float: left; margin-right: 5px; display: inline-table;" autocomplete="off" />
                        <img id="VCode_img" title="点击刷新验证码" class="code" style="height: 34px;" />
                        <input type="hidden" id="VCode_hid" name="VCode_hid" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="EBtnSubmit2" Style="display: none;" OnClick="EBtnSubmit_Click" CssClass="btn btn-primary" runat="server" />
                        <a href="javascript:;" onclick="ebtn_click();" class="btn btn-success  btn-lg"><i class="fa fa-pencil"></i>提交留言</a>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div id="addDiv" runat="server" class="container text-center">
        <a href="Default.aspx?CateID=1" class="btn btn-success  btn-lg"><i class="fa fa-pencil"></i>发表留言</a>
    </div>

    <div class="ask_bottom">
        <p class="text-center"><a target="_blank" title="如何提问" href="http://help.Zoomla.cn/?index/help.html#如何提问">如何提问</a> <a target="_blank" title="如何回答" href="http://help.Zoomla.cn/?index/help.html#如何回答">如何回答</a> <a target="_blank" title="如何获得积分" href="http://help.Zoomla.cn/?index/help.html#如何获得积分">如何获得积分</a> <a target="_blank" title="如何处理问题" href="http://help.Zoomla.cn/?index/help.html#如何处理问题">如何处理问题</a></p>
        <p class="text-center"><%Call.Label("{$Copyright/}"); %></p>
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Script">
    <script src="/JS/ZL_ValidateCode.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#VCode").ValidateCode();

            var mindex = <%= string.IsNullOrEmpty(Request.QueryString["CateID"]) ? "0" : Request.QueryString["CateID"]%>;
            $('#lmenu'+mindex).addClass("active");
            
        })
        $("#Search_B").click(function () {
            window.location.href = "Default.aspx?skey=" + $("#txtName").val();
        });
        function ebtn_click() {
            $("#EBtnSubmit2").click();
        }
        //ajax分页
        function LoadByAjax(query, page) {
            var url = "Default.aspx" + query + "page=" + page;
            console.log(url);
            window.location.href = url;
        }
        function CheckDirty() {
            $("#TxtTContent").val(UE.getEditor("TxtTContent").getContent());
            var value = $("#TxtTContent").val();
            var TxtTTitle = document.getElementById("TxtTTitle").value;
            var TxtValidateCode = document.getElementById("VCode").value;
            if (value == "" || TxtTTitle == "" || TxtValidateCode == "") {
                if (value == "") {

                    var obj = document.getElementById("RequiredFieldValidator1");
                    obj.innerHTML = "<font color='red'>内容不能为空！</font>";
                }
                else {
                    var obj = document.getElementById("RequiredFieldValidator1");
                    obj.innerHTML = "";
                }
                if (TxtTTitle == "") {
                    var obj2 = document.getElementById("RequiredFieldValidator2");
                    obj2.innerHTML = "<font color='red'>留言标题不能为空！</font>";
                }
                else {
                    var obj2 = document.getElementById("RequiredFieldValidator2");
                    obj2.innerHTML = "";
                }
                if (TxtValidateCode == "") {
                    var obj3 = document.getElementById("sp1");
                    obj3.innerHTML = "<font color='red'>验证码不能为空！</font>";
                }
                else {
                    var obj3 = document.getElementById("sp1");
                    obj3.innerHTML = "";
                }
                return false;
            }
            else {
                var obj = document.getElementById("RequiredFieldValidator1");
                obj.innerHTML = "";
                var obj2 = document.getElementById("RequiredFieldValidator2");
                obj2.innerHTML = "";
                var obj3 = document.getElementById("sp1");
                obj3.innerHTML = "";
                document.getElementById("EBtnSubmit2").click();
            }
        }
    </script>
</asp:Content>
