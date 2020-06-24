﻿<%@ page language="C#" autoeventwireup="true" masterpagefile="~/Manage/I/Default.master" inherits="Manage_Content_SelContentTitle, App_Web_zxpqkarz" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content ContentPlaceHolderID="head" runat="Server">
<title>选择文件</title>
<script type="text/javascript" src="/JS/ICMS/alt.js"></script>
<style>
.check { display: block !important;}
.content_list .badge {display: none;}
</style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div class="container-fluid">
    <div class="input-group text_300" style="margin-left:15px;">
        <asp:TextBox ID="ImgName_T" runat="server" CssClass="form-control text_500" placeholder="标题名"></asp:TextBox>
        <span class="input-group-btn">
            <asp:Button ID="Search_B" CssClass="btn btn-info" OnClick="Search_B_Click" runat="server" Text="搜索"></asp:Button>
            <button type="button" onclick="window.location = location;" class="btn btn-info">刷新</button>
        </span>
    </div>
        </div>
        <div class="container-fluid margin_t5">
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                <div class="panel panel-info">
                    <div class="panel-heading">可选内容列表(<span id="check_sp">0</span>/<span id="count_sp">0</span>)</div>
                    <div class="list-group content_list">
                        <ZL:ExRepeater ID="Content_RPT" runat="server" PageSize="10" PagePre="<div class='panel-footer text-center'>" PageEnd="</div>">
                            <ItemTemplate>
                                <a href="javascript:;" onclick="CheckCur(this)" data-id="<%#Eval("GeneralID") %>|<%#Eval("Title") %>" class="list-group-item">
                                    <span class="badge"><span class="glyphicon glyphicon-ok"></span></span>
                                    <span class="content"><%#Eval("Title") %></span>
                                </a>
                            </ItemTemplate>
                            <FooterTemplate></FooterTemplate>
                        </ZL:ExRepeater>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                <div class="panel panel-success">
                    <div class="panel-heading">已选择内容</div>
                    <ul class="list-group" id="checklist">
                        
                    </ul>
                </div>
            </div>
        </div>
         <div class="container-fluid text-center">
             <button type="button" onclick="ConvertData()" class="btn btn-primary">确定</button>
             <button type="button" class="btn btn-primary">取消</button>
         </div>
        <ul class="list-group" id="checkTemp" style="display:none;">
            <li class="list-group-item">
                <a href="javascript:;" onclick="unCheck('@ID')" class="badge"><span class="glyphicon glyphicon-trash"></span></a>
                @Title
            </li>
        </ul>
        <asp:HiddenField ID="ids_hid" runat="server" />
        <asp:HiddenField ID="ContentCount_Hid" runat="server" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script>
            $().ready(function () {
                initCheckList();
                $("#count_sp").text($('#ContentCount_Hid').val())
            });
            //初始化选中数据
            function initCheckList() {
                $(".content_list .badge").removeClass('check');//移除所有选中状态
                $("#checklist").html('');//清空已选内容表里的数据
                var attr = $("#ids_hid").val().split(',');//读取已选择的ids数组 格式为:",id|title,"
                var checkcout = 0;//计算已选数量
                for (var i = 0; i < attr.length; i++) {
                    if (attr[i].trim() != "") {
                        $("#checklist").append($("#checkTemp").html().replace('@ID',attr[i]).replace('@Title', attr[i].split('|')[1]));//向已选择列表添加一项数据
                        $($("[data-id='" + attr[i] + "']")).find('.badge').addClass('check');//选中状态
                        checkcout++;
                    }
                }
                $("#check_sp").text(checkcout);
            }
            //点击选中操作
            function CheckCur(obj) {
                if ($(obj).find('.badge').hasClass('check')) {
                    $("#ids_hid").val($("#ids_hid").val().replace(',' + $(obj).data('id') + ',', ''));//从ids里移除id
                    $(obj).find('.badge').removeClass('check');
                } else {
                    $("#ids_hid").val($("#ids_hid").val() + ',' + $(obj).data('id') + ',');//向ids添加id
                    $(obj).find('.badge').addClass('check');
                }
                initCheckList();
            }
            //已选择列表里的删除操作
            function unCheck(id) {
                $("#ids_hid").val($("#ids_hid").val().replace(',' +id + ',', ''));
                initCheckList();
            }
            //将ids转换为",id,"的格式,并发送到父页面
            function ConvertData() {
                var attr = $('#ids_hid').val().split(',');
                var tempdata = "";
                for (var i = 0; i < attr.length; i++) {
                    if (attr[i].trim() != "") {
                        tempdata += ',' + attr[i].split('|')[0] + ',';
                    }
                }
               
                parent.PageCallBack('SelContent',tempdata,null);
            }
        </script>
</asp:Content>
