﻿<%@ page language="C#" autoeventwireup="true" inherits="manage_Flex_FlexTemplate, App_Web_dof0p5hd" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
        <title>Flex管理系统</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ZL:ExGridView ID="Egv" runat="server" AutoGenerateColumns="False" DataKeyNames="Mu_ID" PageSize="10" OnPageIndexChanging="Egv_PageIndexChanging" IsHoldState="false" OnRowCommand="Egv_RowCommand" AllowPaging="True" AllowSorting="True" CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True" EmptyDataText="暂无相关信息！！">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <input type="checkbox" name="idchk" title="" value='<%#Eval("Mu_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="ID" DataField="Mu_ID" />
            <asp:BoundField HeaderText="礼品名称" DataField="Mu_Title" />
            <asp:TemplateField HeaderText="所属产品">
                <ItemTemplate>
                    <%#GetPClass(Eval("Mu_PClass"))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="所属分类">
                <ItemTemplate>
                    <%#GetClass(Eval("Mu_Class"))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="模板类型">
                <ItemTemplate>
                    <%#Eval("Mu_ModelTemp").ToString() == "1" ? "页面模板" : "成套模板"%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="排序" DataField="Mu_Num" />
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <%#Getaction(Eval("Mu_ID"))%>&nbsp;&nbsp;<a href="AddTemplate.aspx?menu=edit&id=<%#Eval("Mu_ID") %>" class="option_style"><i class="fa fa-pencil" title="修改"></i>></a>
                    <asp:LinkButton ID="LinkButton1" CommandArgument='<%#Eval("Mu_ID") %>' CommandName="del1" runat="server" CssClass="option_style"><i class="fa fa-trash-o" title="删除"></i>删除</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>
    <div>
        <asp:Button ID="Button3" class="btn btn-primary" runat="server" OnClientClick="return confirm('不可恢复性删除数据,你确定将该数据删除吗？');" Text="批量删除" OnClick="Button3_Click" />
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
    <script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
    <script>
        $().ready(function () {
            $("#Egv tr").dblclick(function () {
                var id = $(this).find("[name=idchk]").val();
                if (id) {
                    location = "AddTemplate.aspx?menu=edit&id="+id;
                }
            });
        })
    </script>
</asp:Content>