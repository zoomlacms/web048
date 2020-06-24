<%@ page language="C#" autoeventwireup="true" inherits="Manage_Content_Addon_Schedule_Default, App_Web_pwdad0k4" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>
<%@ Register Src="~/Manage/I/ASCX/SPwd.ascx" TagPrefix="uc1" TagName="SPwd" %>
<asp:Content runat="server" ContentPlaceHolderID="head"><title>任务列表</title></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
<uc1:SPwd runat="server" ID="SPwd" Visible="false" />
<div id="maindiv" runat="server" visible="false">
<ZL:ExGridView ID="EGV" runat="server" AutoGenerateColumns="False" PageSize="10" IsHoldState="false" 
        OnPageIndexChanging="EGV_PageIndexChanging" AllowPaging="True" AllowSorting="True" OnRowCommand="EGV_RowCommand" OnRowDataBound="EGV_RowDataBound"
        CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True" EmptyDataText="数据为空">
        <Columns>
            <asp:TemplateField ItemStyle-CssClass="td_s">
                <ItemTemplate>
                    <input type="checkbox" name="idchk" value="<%#Eval("ID") %>" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="ID" DataField="ID" ItemStyle-CssClass="td_s"/>
            <asp:BoundField HeaderText="任务名称" DataField="TaskName" />
            <asp:TemplateField HeaderText="执行计划">
                <ItemTemplate>
                    <%#GetExecuteType() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="执行时间">
                <ItemTemplate>
                      <%#GetExecuteTime() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="最近一次执行">
                <ItemTemplate>
                    <%#GetLastTime() %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="创建时间" DataField="CDate" DataFormatString="{0:yyyy年MM月dd日}"  />
            <asp:BoundField HeaderText="备注" DataField="Remind" />
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <a class="option_style" href="AddSche.aspx?id=<%#Eval("ID") %>"><i class="fa fa-pencil" title="修改"></i></a>
                    <asp:LinkButton runat="server" CssClass="option_style" CommandName="del2" CommandArgument='<%#Eval("ID") %>' OnClientClick="return confirm('确定要删除吗');"><i class="fa fa-trash-o" title="删除"></i></asp:LinkButton>
                    <a class="option_style" href="ScheLogList.aspx?TaskID=<%#Eval("ID") %>"><i class="fa fa-file"></i>查看日志</a>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>
<a href='TaskList.aspx' class="btn btn-info">任务队列</a>
<asp:Button runat="server" ID="InitTask_Btn" Text="初始化任务" class="btn btn-info" OnClick="InitTask_Btn_Click" OnClientClick="return confirm('初始化会清空队列并重新生成任务,确定要初始化吗');"/>
</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">

</asp:Content>