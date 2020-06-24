﻿<%@ page language="C#" autoeventwireup="true" inherits="manage_Flex_ProteatManage, App_Web_dof0p5hd" enableviewstatemac="false" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>Flex管理系统</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <ZL:ExGridView ID="Egv" runat="server" AutoGenerateColumns="False" DataKeyNames="p_ID" PageSize="10" OnPageIndexChanging="Egv_PageIndexChanging" IsHoldState="false" OnRowCommand="Egv_RowCommand" AllowPaging="True" AllowSorting="True" CssClass="table table-striped table-bordered table-hover" EnableTheming="False" EnableModelValidation="True" EmptyDataText="暂无相关信息！！">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <input type="checkbox" name="idchk" title="" value='<%#Eval("p_ID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="ID" DataField="p_ID" />
            <asp:BoundField HeaderText="产品名称" DataField="p_Name" />
            <asp:TemplateField HeaderText="产品类型">
                <ItemTemplate>
                    <%#Getclass(Eval("p_Type"))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="产品排序" DataField="p_num" />
            <asp:TemplateField HeaderText="操作">
                <ItemTemplate>
                    <a href="Addproduct.aspx?menu=edit&id=<%#Eval("p_ID") %>" class="option_style"><i class="fa fa-pencil" title="修改"></i></a>
                    <asp:LinkButton ID="LinkButton1" CommandName="del1" CommandArgument='<%#Eval("p_ID") %>' runat="server" CssClass="option_style"><i class="fa fa-trash-o" title="删除"></i>删除</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </ZL:ExGridView>
    <div>
        <asp:Button ID="Button3" class="btn btn-primary" Style="width: 110px;" runat="server" OnClientClick="return confirm('不可恢复性删除数据,你确定将该数据删除吗？');" Text="批量删除" OnClick="Button3_Click" />
    </div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
     <script type="text/javascript" src="/JS/SelectCheckBox.js"></script>
    <script type="text/javascript" src="/JS/ICMS/ZL_Common.js"></script>
    <script>
        $().ready(function () {
            $("#Egv tr").dblclick(function () {
                var id = $(this).find("[name=idchk]").val();
                if (id) {
                    location = "Addproduct.aspx?menu=edit&id=" + id;
                }
            });
        })
    </script>
</asp:Content>
