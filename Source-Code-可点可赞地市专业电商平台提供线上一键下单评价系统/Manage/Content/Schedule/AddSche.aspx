<%@ page language="C#" autoeventwireup="true" inherits="Manage_Content_Addon_Schedule_AddSche, App_Web_pwdad0k4" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="~/Manage/I/ASCX/SPwd.ascx" TagPrefix="uc1" TagName="SPwd" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>添加任务</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<uc1:SPwd runat="server" ID="SPwd" Visible="false" />
<div id="maindiv" runat="server" visible="false">
<table class="table table-bordered table-striped">
    <tr><td class="td_m">任务名称</td><td><ZL:TextBox runat="server" ID="TaskName_T" CssClass="form-control text_300" AllowEmpty="false" ValidType="String" /></td></tr>
    <tr><td>任务类型</td><td>
        <label><input type="radio" name="taskType_rad" checked="checked" value="1" />执行SQL</label>
   <%--     <label><input name="taskType_rad" type="radio" value="2" disabled="disabled" />生成发布(系统)</label>
        <label><input name="taskType_rad" type="radio" value="3" disabled="disabled"/>内容审核(系统)</label>--%>
    </td></tr>
    <tr><td>执行计划</td><td>
        <label><input type="radio" name="executeType_rad" value="0" checked="checked" />仅一次</label>
        <label><input type="radio" name="executeType_rad" value="1" />每日</label>
        <label><input type="radio" name="executeType_rad" value="2" />循环(每隔指定时间)</label>
    </td></tr>
    <tr id="date_tr" class="time_tr"><td>执行时间</td><td><asp:TextBox runat="server" ID="ExecuteTime_T" CssClass="form-control text_300" onclick="WdatePicker({ dateFmt: 'yyyy/MM/dd HH:mm:ss' });"/></td></tr>
    <tr id="interval_tr" class="time_tr"><td>间隔时间</td><td>
        <div class="input-group text_300">
            <ZL:TextBox runat="server" ID="Interval_T" CssClass="form-control text_300" ValidType="IntPostive" />
            <span class="input-group-addon">分钟</span>
        </div>
    </td></tr>
    <tr><td>任务状态</td>
       <td>
           <label><input type="radio" name="status_rad" value="0" checked="checked" />正常</label>
           <label><input type="radio" name="status_rad" value="-1" />停用</label>
           <label><input type="radio" name="status_rad" value="100" />已完成</label>
       </td>
    </tr>
    <tr><td>任务内容</td><td><ZL:TextBox runat="server" TextMode="MultiLine" ID="TaskContent_T" CssClass="form-control m715-50" style="height:100px;" AllowEmpty="false"/></td></tr>
    <tr><td>备注</td><td><asp:TextBox runat="server" ID="Remind_T" CssClass="form-control m715-50"/></td></tr>
    <tr><td></td><td>
        <asp:Button runat="server" ID="Save_Btn" Text="保存信息" OnClick="Save_Btn_Click" CssClass="btn btn-primary" />
        <a href="Default.aspx" class="btn btn-default">返回列表</a>
                 </td></tr>
</table>
</div>

</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script src="/JS/DatePicker/WdatePicker.js"></script>
<script src="/JS/SelectCheckBox.js"></script>
<style type="text/css">
.time_tr {display:none;}
</style>
<script>
function ShowTimeTr() {
    $(".time_tr").hide();
    var value = $("input[name=executeType_rad]:checked").val();
    if (value == 2) { $("#interval_tr").show(); }
    else { $("#date_tr").show(); }
}
$(function () {
    ShowTimeTr();
    $("input[name=executeType_rad]").click(ShowTimeTr);
})
</script>
</asp:Content>