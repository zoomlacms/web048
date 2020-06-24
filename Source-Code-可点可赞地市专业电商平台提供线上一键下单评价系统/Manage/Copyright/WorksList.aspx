<%@ page language="C#" autoeventwireup="true" inherits="Manage_Copyright_WorksList, App_Web_fkpuhzmx" masterpagefile="~/Manage/I/Default.master" enableEventValidation="false" viewStateEncryptionMode="Never" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <title>我的作品</title>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <iframe runat="server" id="workslist_ifr" style="width:100%;" frameborder="0" marginheight="0" marginwidth="0"></iframe>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="ScriptContent">
<script>
    $("#workslist_ifr").load(function () {
        var $obj = $(this);
        $obj.height($(document).height() - 120);
    });
</script>
</asp:Content>
