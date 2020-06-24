﻿<%@ page language="C#" autoeventwireup="true" inherits="User_MySubscription, App_Web_azpey0zz" enableviewstatemac="false" masterpagefile="~/User/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
<title>评论管理</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<div id="pageflag" data-nav="group" data-ban="sub"></div>
<div class="container margin_t5">
<ol class="breadcrumb">
<li><a title="会员中心" href="/User/Default.aspx">会员中心</a></li>
<li class="active">订阅管理</li> 
</ol>
</div>
<div class="us_seta u_cnt container" id="Tabs0">
<table class="table table-striped table-bordered table-hover">
	<tr>
		<td colspan="5" class="text-center">
			<asp:Label ID="Label1" runat="server" Text="我的订阅管理"></asp:Label>
		</td>
	</tr>
	<tr>
		<td>订阅编号</td>
		<td>订阅标题</td>
		<td>生效日期</td>
		<td>到期日期</td>
		<td>操作</td>
	</tr>
	<ZL:ExRepeater ID="MySub" runat="server" PagePre="<tr><td colspan='5' class='text-center'><input type='checkbox' id='CheckAll' />" PageEnd="</td></tr>" OnItemDataBound="MySub_ItemDataBound">
		<ItemTemplate>
			<tr>
				<td style="width: 18%; white-space: nowrap; overflow: hidden"><%#Eval("Id")%></td>
				<td style="width: 20%; white-space: nowrap; overflow: hidden">
					<asp:HiddenField ID="hfid" runat="server" Value='<%#Eval("id") %>' />
					<asp:HyperLink ID="lbTitle" runat="server"><%#Eval("title") %></asp:HyperLink>
				</td>
				<td style="width: 20%;"><%#Eval("effectTime")%></td>
				<td style="width: 20%;"><%#Eval("endTime","{0}")%> </td>
				<td style="width: 20%; text-align: center;">
					<asp:LinkButton ID="lbDel" runat="server" CommandName="Del" CommandArgument='<%# Eval("Id") %>'>删除</asp:LinkButton>
				</td>
			</tr>
		</ItemTemplate>
		<FooterTemplate></FooterTemplate>
	</ZL:ExRepeater>
</table>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script type="text/JavaScript">
var tID = 0;
var arrTabTitle = new Array("TabTitle0", "TabTitle1");
var arrTabs = new Array("Tabs0", "Tabs1");
function ShowTabs(ID) {
if (ID != tID) {
	document.getElementById(arrTabTitle[tID].toString()).className = "tabtitle";
	document.getElementById(arrTabTitle[ID].toString()).className = "titlemouseover";
	document.getElementById(arrTabs[tID].toString()).style.display = "none";
	document.getElementById(arrTabs[ID].toString()).style.display = "";
	tID = ID;
}
}
</script>
<script type="text/javascript">
//根据传入的checkbox的选中状态设置所有checkbox的选中状态
function selectAll(obj) {
var allInput = document.getElementsByTagName("input");
//alert(allInput.length);
var loopTime = allInput.length;
for (i = 0; i < loopTime; i++) {
	//alert(allInput[i].type);
	if (allInput[i].type == "checkbox") {
		allInput[i].checked = obj.checked;
	}
}
}
//判断是否选中记录，用户确认删除
function judgeSelect() {
var result = false;
var allInput = document.getElementsByTagName("input");
var loopTime = allInput.length;
for (i = 0; i < loopTime; i++) {
	if (allInput[i].checked) {
		result = true;
		break;
	}
}
if (!result) {
	alert("请先选择要删除的记录！");
	return result;
}
result = confirm("你确认要删除选定的记录吗？");
return result;
}
</script>
</asp:Content>