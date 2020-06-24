﻿<%@ page language="C#" masterpagefile="~/User/Default.master" autoeventwireup="true" inherits="User_Info_UserRecei, App_Web_qgr2pzqu" clientidmode="Static" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
<title>用户地址薄</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div id="pageflag" data-nav="shop" data-ban="shop"></div>
<div class="container margin_t5">
<ol class="breadcrumb" style="margin-bottom:5px;">
<li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
<li class="active">我的地址薄</li>
</ol>
</div>
<div class="container">
<div><a href="AddUserAddress.aspx" class="btn btn-info">新增收货地址</a></div>
<ul id="addul" class="list-unstyled margin_t5">
        <ZL:ExRepeater runat="server" ID="RPT" PageSize="9" PagePre="<div class='clearfix'></div><div class='text-center'>" PageEnd="</div>" OnItemCommand="RPT_ItemCommand" OnItemDataBound="RPT_ItemDataBound">
            <ItemTemplate>
                <li class="col-lg-4 col-md-4 col-xs-6 col-sm-6" style="padding-left:0px;">
                    <div class="panel <%#Eval("isDefault","").Equals("1")?"panel-info":"panel-default" %>  text-left">
                        <div class="panel-heading">
                            <i class="fa fa-user"></i> <strong><%#Eval("ReceivName") %></strong> <i class="fa fa-mobile-phone" style="font-size:16px;"></i> <%#Eval("MobileNum")%>
                            <%#Eval("isDefault","").Equals("1")?" <i class='fa fa-check pull-right' title='默认'></i>":""%>
                        </div>
                        <div class="panel-body">
                            <div><div class="add_left">所在地区：</div><span><%# Eval("Provinces") %></span></div>
                            <div><div class="add_left">地址：</div><%# Eval("Street") %></div>
                            <div><div class="add_left">邮编：</div><%# Eval("ZipCode") %></div>
                        </div>
                        <div class="panel-footer">
                            <span><a href="AddUserAddress.aspx?id=<%#Eval("ID") %>" title="修改"><i class="fa fa-pencil"></i>修改</a></span>
                            <asp:LinkButton runat="server" CommandArgument='<%#Eval("ID") %>' OnClientClick="return confirm('你确定要删除吗!');" ToolTip="删除" CommandName="del"><i class="fa fa-trash"></i>删除</asp:LinkButton>
                            <asp:LinkButton ID="Def_Btn" runat="server" CssClass="pull-right" CommandArgument='<%#Eval("ID") %>' CommandName="def">设为默认</asp:LinkButton>
                        </div>
                    </div>
                </li>
            </ItemTemplate>
            <FooterTemplate></FooterTemplate>
        </ZL:ExRepeater>
    </ul>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <style type="text/css">
        .add_left {text-align:right;color:#999;display:inline-block;width:70px;line-height:22px;}
    </style>
</asp:Content>